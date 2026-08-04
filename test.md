# Monitor Design Guide

**Audience:** Engineers designing, reviewing, or troubleshooting production
monitors and alerts.

**Purpose:** Ensure every monitor we deploy is actionable, owned, and
supported by a runbook, so that every alert provides a clear response path
rather than simply reporting that something has gone wrong.

---

## Diagram

![Monitor design pipeline: seven stages from understanding the microservice
to authoring the runbook, gated by the four alert principles, fed by RED
metrics and SLA/SLI/SLO, ending at a production-readiness
check](./monitor-design-guide-flow.svg)

---

## Why This Matters

A monitor that fires without a clear next step creates operational noise
instead of operational value. It interrupts the on-call engineer without
providing enough context to resolve the issue, ultimately reducing
confidence in the alerting system.

A well-designed monitor should answer four questions immediately:

* **What happened?**
* **How severe is it?**
* **Who owns it?**
* **What should be done next?**

This guide provides a standard process for designing monitors that are
reliable, actionable, and aligned with Site Reliability Engineering (SRE)
best practices.

---

## 1. Monitor Design Pipeline

When creating a new monitor—or reviewing an existing one—follow these seven
stages. Each stage produces information required by the next, so avoid
skipping directly to implementation before understanding the service and
its failure modes.

| Stage  | Name                        | Objective                                                                                                     | Key Inputs                                                     |
| ------ | --------------------------- | ------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------- |
| **01** | Understand the Microservice | Understand what the service does, who owns it, and which systems depend on it.                                | Service ownership, architecture diagrams, dependency graph     |
| **02** | Identify Failure Modes      | Identify the errors and failure scenarios the service can produce.                                            | API contracts, logs, exception types, error codes              |
| **03** | Assess Severity             | Determine the business and operational impact of each failure mode.                                           | Customer impact, support impact, incident severity definitions |
| **04** | Review Incident History     | Understand how frequently each failure mode has occurred and whether it has previously required intervention. | Jira incidents, PagerDuty history, postmortems                 |
| **05** | Select the Alert Channel    | Route alerts according to their urgency and required response.                                                | PagerDuty, Slack, Email                                        |
| **06** | Design the Monitor          | Define the alert condition, threshold, owner, and escalation criteria using service reliability metrics.      | RED metrics, SLI, SLO, SLA                                     |
| **07** | Author the Runbook          | Document the investigation and recovery steps for responders.                                                 | Monitor definition, operational procedures                     |

---

### Stage 06 Principles

Every production monitor should satisfy the following principles.

#### Actionable

An alert must require a clear action.

If the responder cannot determine what to investigate or fix after
receiving the alert, the monitor should be redesigned.

#### Customer Focused

Whenever possible, monitor symptoms experienced by customers rather than
internal infrastructure metrics.

For example, prefer monitoring:

* Request error rate
* Request latency
* Service availability

instead of paging directly on:

* CPU utilization
* Memory usage
* Pod restarts

Infrastructure metrics remain valuable for diagnosis but should generally
support investigation rather than serve as primary paging conditions unless
they directly threaten service availability.

#### Owned

Every monitor must identify a responsible team or service owner.

#### Documented

Every paging alert must include a direct link to its runbook so responders
can begin remediation immediately.

---

## 2. Metrics Framework — RED

The RED methodology helps determine **what should be measured** for
request-driven services.

| Metric       | Definition                                                                                           |
| ------------ | ---------------------------------------------------------------------------------------------------- |
| **Rate**     | Number of requests received over time, representing service workload.                                |
| **Errors**   | Percentage of requests that fail.                                                                    |
| **Duration** | Time required to complete requests, typically measured using latency percentiles such as p95 or p99. |

These metrics often become the service's primary Service Level Indicators (SLIs).

---

## 3. Service Level Framework — SLA / SLI / SLO

The Service Level framework defines **how reliability is measured and what
constitutes acceptable performance**.

| Term                              | Definition                                                                                                     |
| --------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| **Service Level Indicator (SLI)** | A measurable indicator of service performance, such as availability, latency, or error rate.                   |
| **Service Level Objective (SLO)** | The target value for an SLI that engineering aims to achieve.                                                  |
| **Service Level Agreement (SLA)** | A formal commitment made to customers, often including contractual consequences if service levels are not met. |

Example:

| RED Metric | Example SLI             | Example SLO                             |
| ---------- | ----------------------- | --------------------------------------- |
| Errors     | Successful request rate | ≥ 99.9% over 30 days                    |
| Duration   | p95 request latency     | < 300 ms                                |
| Rate       | Requests per second     | Monitored for abnormal traffic patterns |

Monitors should generally alert when an SLI is at risk of violating its
corresponding SLO.

---

## 4. Designing Effective Monitors

A production monitor should answer the following questions:

* Does this detect a customer-visible problem?
* Is the alert actionable?
* Is there a clearly defined owner?
* Is the threshold based on an SLI and SLO?
* Does the alert include sufficient diagnostic context?
* Is there a linked runbook?
* Has the alert been reviewed to minimise false positives and alert fatigue?

If any answer is **No**, the monitor should be revised before deployment.

---

## 5. Applying This Guide

When proposing or reviewing a monitor:

* Reference the pipeline stage that informed each design decision (for
  example, **Stage 03: Customer-impacting, Severity 2**).
* Link the runbook directly from the monitor configuration (PagerDuty,
  Datadog, or equivalent), not solely from documentation.
* Reference this guide in the pull request or change request when
  introducing, modifying, or reviewing production monitors.
* Review monitor effectiveness after incidents to ensure thresholds remain
  accurate and alerts continue to be actionable.

---

### 6. Monitor Design Checklist

Use this checklist when creating, reviewing, or approving a production monitor.

| Category                  | Checklist                                                                      |  ✓  |
| ------------------------- | ------------------------------------------------------------------------------ | :-: |
| **Service Understanding** | The service owner has been identified.                                         |  ☐  |
|                           | The service dependencies are understood.                                       |  ☐  |
| **Failure Modes**         | The monitor targets a known failure mode or customer-impacting scenario.       |  ☐  |
|                           | The trigger condition is clearly defined.                                      |  ☐  |
| **Severity**              | The business impact has been classified (e.g., Sev1, Sev2, Sev3).              |  ☐  |
|                           | The alert priority matches its business impact.                                |  ☐  |
| **Metrics**               | The monitor is based on an appropriate RED metric (Rate, Errors, or Duration). |  ☐  |
|                           | The measured metric is a defined Service Level Indicator (SLI).                |  ☐  |
|                           | The threshold is derived from an agreed Service Level Objective (SLO).         |  ☐  |
| **Alert Design**          | The alert detects a customer-visible issue whenever possible.                  |  ☐  |
|                           | The alert is actionable and has a clear next step.                             |  ☐  |
|                           | The alert has an identified service owner or responding team.                  |  ☐  |
|                           | The alert contains sufficient context for initial investigation.               |  ☐  |
| **Routing**               | The alert is routed to the appropriate channel (PagerDuty, Slack, Email).      |  ☐  |
| **Documentation**         | A runbook exists and is linked directly from the monitor.                      |  ☐  |
|                           | Investigation and recovery steps have been documented.                         |  ☐  |
| **Quality**               | Historical incidents have been reviewed to validate the threshold.             |  ☐  |
|                           | The monitor has been evaluated for false positives and alert fatigue.          |  ☐  |
|                           | The monitor has been peer reviewed before deployment.                          |  ☐  |

#### Ready for Production

A monitor is considered production-ready only if all of the following are true:

* ☐ It detects a meaningful service degradation.
* ☐ It requires a clear response from the on-call engineer.
* ☐ It has a defined owner.
* ☐ It is measured using an SLI with a threshold based on an SLO.
* ☐ It is routed to the appropriate notification channel.
* ☐ It includes a linked runbook.
* ☐ It has been reviewed for accuracy and operational noise.

---

## Summary

A reliable monitor follows a simple flow:

```text
Understand the Service
        ↓
Identify Failure Modes
        ↓
Assess Business Impact
        ↓
Review Incident History
        ↓
Choose Alert Channel
        ↓
Measure RED Metrics (SLIs)
        ↓
Define SLO Thresholds
        ↓
Create Actionable Monitor
        ↓
Link Runbook
        ↓
Respond and Improve
```

By following this process, every alert should lead directly to an informed
response, reducing alert fatigue while improving service reliability and
incident response effectiveness.

---

# Case Scenario: Order Management Microservice

## Background

You are the DevOps/SRE owner for an e-commerce platform.

The platform allows customers to:

1. Browse products
2. Add items to cart
3. Checkout
4. Make payment
5. Receive order confirmation

The company has recently grown, and the engineering team wants better
observability before the next peak sales event.

Your task:

> Design the production monitoring strategy for the Order Management
> Service using Datadog.

---

## System Architecture

```text
                         Customers
                             |
                             |
                         Web Browser
                             |
                             |
                       React Frontend
                             |
                             |
                    Azure Application Gateway
                             |
                             |
                         Kubernetes
                             |
              +--------------+--------------+
              |                             |
        Order API Pods              Background Worker Pods
              |
              |
        +-----+-------+
        |             |
    PostgreSQL      Redis
        |
        |
 Payment Service  Inventory Service
```

---

## Service Information

### Service Name

Order Management Service

### Business Function

Responsible for:

* Creating orders
* Updating order status
* Checking inventory availability
* Processing payment requests
* Returning order confirmation

### API Endpoints

#### Create Order

```http
POST /api/orders
```

Example request:

```json
{
  "customerId": "12345",
  "items": [
    {
      "productId": "A001",
      "quantity": 2
    }
  ]
}
```

Possible responses:

```text
201 Created
400 Bad Request
401 Unauthorized
409 Conflict
500 Internal Server Error
503 Service Unavailable
```

---

#### Get Order

```http
GET /api/orders/{orderId}
```

Possible responses:

```text
200 OK
404 Not Found
500 Internal Server Error
```

---

#### Update Order Status

```http
PUT /api/orders/{orderId}/status
```

Used internally by payment and inventory services.

---

## Infrastructure Details

### Kubernetes Cluster

Production cluster:

```text
Cluster:
production-aks

Namespace:
commerce-prod

Node Pool:
8 nodes

Node Size:
Standard_D4ds_v5

Applications:

order-api:
  replicas: 6

order-worker:
  replicas: 3
```

---

### Deployment Details

Order API:

```text
Technology:
.NET 8 Web API

Container:
Docker

Resources:

CPU Request:
500m

CPU Limit:
2

Memory Request:
1GB

Memory Limit:
2GB
```

---

## Dependencies

### PostgreSQL Database

Used for:

* Customer orders
* Order status
* Payment records

Database:

```text
Azure PostgreSQL Flexible Server

Storage:
1TB

Connection Pool:
100 connections
```

---

### Redis

Used for:

* Product availability cache
* Temporary checkout sessions

---

### Payment Service

External internal service.

SLA:

```text
99.9% availability
```

Average response:

```text
200ms
```

Timeout configured:

```text
5 seconds
```

---

### Inventory Service

Responsible for:

* Stock checking
* Stock reservation

Average response:

```text
300ms
```

Timeout:

```text
3 seconds
```

---

## Current Problems

The team has experienced several incidents recently.

### Incident 1

During a flash sale:

Customers reported:

> "Checkout keeps spinning and never completes."

Investigation found:

* API response time increased
* Database CPU reached 95%
* No alerts fired

---

### Incident 2

After a deployment:

Some customers received:

```text
HTTP 500
Internal Server Error
```

Investigation found:

* New code introduced an exception
* Pods were still healthy
* Kubernetes did not restart anything

---

### Incident 3

At midnight:

The service became unavailable.

Root cause:

* Database connection limit reached
* New API requests could not get DB connections

---

### Incident 4

Frontend team reported:

> "Some users see a blank checkout page."

Investigation found:

* Javascript error after a frontend release
* Backend services were healthy

---

### Incident 5

A Kubernetes node became unhealthy.

Effects:

* 2 API pods disappeared
* Remaining pods handled traffic
* No customer impact

---

## Available Datadog Data Sources

You have access to:

### Datadog APM

Available:

* Request traces
* Endpoint latency
* Error traces
* Database spans
* External API spans

---

### Datadog Logs

Application logs include:

Example:

```text
INFO Order created successfully

WARN Payment timeout

ERROR Database connection timeout

ERROR NullReferenceException

ERROR Inventory reservation failed
```

---

### Datadog Kubernetes Monitoring

Available:

* Pod status
* Container CPU
* Container memory
* Node status
* Deployment status
* Restart count
* Events

---

### Datadog RUM

Available:

* Frontend errors
* Page load performance
* User sessions
* Failed API calls

---

## Business Requirements

The business team defines:

### Customer Impact Priority

Highest priority:

1. Customer cannot checkout
2. Customer payment fails
3. Orders are created incorrectly
4. Website performance degradation

Lower priority:

* Individual pod failure
* Non-production issues
* Infrastructure events without customer impact

---

## Your Task

Using the Monitor Design Guide:

Design the monitoring strategy.

Think through:

1. What are the important failure modes?
2. Which ones deserve alerts?
3. Which metrics would you use?
4. What are your SLIs?
5. What SLOs would you define?
6. Which alerts should page?
7. Which alerts should only notify Slack?
8. What runbooks would you need?

---

# How to Survive in Corporate

## 1. Communicate Clearly

Before explaining anything, make sure the listener understands:

* [ ] What is the context?
* [ ] What is the goal?
* [ ] What is the current situation?
* [ ] What do I need from them?

When explaining an issue:

* [ ] Be clear and concise.
* [ ] Avoid unnecessary background details.
* [ ] Explain the impact.
* [ ] Explain my understanding of the problem.
* [ ] State what decision or action is needed.

---

## 2. When Asking for Help

Do not only say:

> "I have an issue."

Provide enough information for others to help quickly.

Use this structure:

### Problem

* [ ] What is happening?
* [ ] What is the expected behaviour?
* [ ] What is the actual behaviour?
* [ ] Who or what is affected?

Example:

> "The deployment is failing during the container startup phase. Expected
> behaviour is for the pod to become ready, but it is stuck in
> CrashLoopBackOff."

---

### Investigation

Explain what you have already tried:

* [ ] What steps have I taken?
* [ ] What logs, metrics, or evidence have I checked?
* [ ] What did I learn from each step?
* [ ] What possible causes have I ruled out?

Example:

> "I checked the pod logs and found a database connection timeout. I
> verified the database is reachable from another pod, so the issue may be
> related to application configuration."

---

### Blocker

Clearly state why you cannot proceed:

* [ ] What is preventing progress?
* [ ] What decision or information is missing?
* [ ] What dependency am I waiting for?

Example:

> "I cannot proceed with the deployment because I need approval to update
> the production secret configuration."

---

### Ask the Right Question

Avoid asking:

> "Can you help me?"

Ask specific questions:

* [ ] What is the recommended approach?
* [ ] What should I try next?
* [ ] Is my understanding correct?
* [ ] Who is the right person/team to consult?

Example:

> "Should I rotate the secret myself, or does the platform team own
> production secret changes?"

---

## 3. When Reporting Work Progress

Use this format:

### Done

* What was completed?
* What result was achieved?

### In Progress

* What am I currently working on?
* What is the expected completion time?

### Blockers

* What is preventing progress?
* What help is needed?

### Next Steps

* What will I do next?
* What decision is required?

---

## 4. When Facing Technical Issues

Follow this mindset:

```text
Understand
    ↓
Investigate
    ↓
Explain
    ↓
Propose
    ↓
Ask
```

Before escalating:

* [ ] I understand the problem statement.
* [ ] I collected evidence.
* [ ] I attempted reasonable solutions.
* [ ] I documented what I learned.
* [ ] I can explain why I am stuck.

---

## 5. Golden Rule

A strong engineer does not need to know everything.

A strong engineer knows how to:

* [ ] Identify problems clearly.
* [ ] Investigate systematically.
* [ ] Communicate progress.
* [ ] Ask effective questions.
* [ ] Bring the right people into the conversation.
* [ ] Move problems forward.

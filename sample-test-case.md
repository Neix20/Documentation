
# Jenkins Email Automation

## [JEAT1]: Perfect Scenario

This test runs as the perfect scenario. Assume no failure occurs.

- Input: `date_time = "20240622"`
- Expected Result:
  - All Status is Healty in Internal Email
  - PH Email is send to report as Healthy
  - TH Email is send to report as Healthy

## [JEAT2]: Octopus API HealthFail

This test runs to simulate when Octopus API returns failure

- Input: `date_time = "20240617"`
- Input: `curl ./emailable-report-fail.html`
- Expected Result:
  - Octopus API report as unhealthy
  - PH Email is not send out
  - TH Email is send to report as Healthy

## [JEAT3]: Kibana Microservice Check Fail

This test runs to simulate when kibana microservice returns failure

- Input: `curl ./ms-kibana-10-177-4-9-9241.log`
- Input: `curl ./ms-kibana-10-177-138-17-9200.log`
- Expected Result:
  - Kibana Microservice returns fail
  - PH Email is send to report as Healthy
  - TH Email is send to report as Healthy

## [JEAT4]: Kibana Microservice File Unable to Found

- Input: ``
- Expected Result:
  - Kibana Microservice returns fail
  - PH Email is send to report as Healthy
  - TH Email is send to report as Healthy

## [JEAT5]: PH Microservice Container Service not Running

- Input: `date_time = "20240602"`
- Expected Result:
  - PH Microservice returns fail
  - PH Email is not send out
  - TH Email is send to report as Healthy

## [JEAT6]: PH Microservice File Unable to Found

- Input: `date_time = "20240604"`
- Expected Result:
  - PH Microservice returns fail
  - PH Email is not send out
  - TH Email is send to report as Healthy

## [JEAT7]: TH Microservice Container Service not Running

- Input: `date_time = "20240602"`
- Expected Result:
  - TH Microservice returns fail
  - PH Email is send to report as Healthy
  - TH Email is not send out

## [JEAT8]: TH Microservice File Unable to Found

- Input: `date_time = "20240604"`
- Expected Result:
  - TH Microservice returns fail
  - PH Email is send to report as Healthy
  - TH Email is not send out

## [JEAT9]: DLS Lead Report Service Not Running

- Input: `date_time = "20240614"`
- Expected Result:
  - TH DLS Report returns fail
  - PH Email is send to report as Healthy
  - TH Email is not send out

## [JEAT10]: DLS Lead Report File Unable Found

- Input: `date_time = "20240617"`
- Expected Result:
  - TH DLS Report returns fail
  - PH Email is send to report as Healthy
  - TH Email is not send out

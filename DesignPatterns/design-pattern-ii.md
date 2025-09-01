
# Design Patterns

## Links

- <https://www.crunchydata.com/blog/tags-aand-postgres-arrays-a-purrfect-combination>
- <https://www.reddit.com/r/aws/comments/9r8sn9/dynamodb_best_practices_for_designing_an_image/>

Dependency Injection for Factory, Allows to `Register` Function

Dependency Injection allows for `Testing`

Testing library have mocking capabilities, that mock based on `interfaces`

Ask yourself questions like this

- "How can I test a method?"
- "I need to set Internal Variable to Test."

## Concepts of OOP

<table>
  <tr>
    <th>Term</th>
    <th>Definition</th>
  </tr>
  <tr>
    <td>Abstraction</td>
    <td>Hiding Internal details and Functionaliesi (Allow Inversion of Control) (Callback) (implements)</td>
  </tr>
  <tr>
    <td>Encapsulation</td>
    <td>Private and Public Field (Getter and Setter)</td>
  </tr>
  <tr>
    <td>Polymorphism</td>
    <td>Overriding and overloading of Function (Change the behavior of function)</td>
  </tr>
  <tr>
    <td>Inheritance</td>
    <td>Reuse Functionalies of Existing Classes (Extends)</td>
  </tr>
</table>

## Use-Case

Do this using typescript. or Java.

Design an Email Service Program using best practices:

There are two people asking for your services. 1 has provided you with an API, and has asked you to generate a CSV File

Another is your company internal person, giving you a database connection and generate a xlsx file.

To do testing, you provided yourself a json file, to convert into csv

- It will read data from API or Database
- It will then generate a csv file, and xlsx file, based on different company.
- Then, it will attach the file, and send to its respective company.

Design a File Uploader Tagging System

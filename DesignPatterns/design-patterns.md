
# Design Patterns

## Links

- <https://www.youtube.com/watch?v=J1f5b4vcxCQ>
- <https://www.youtube.com/watch?v=XVZpi7VJ_ws>
- <https://medium.com/@lucas.rafael.araujo/c-understanding-interfaces-simple-mocking-testing-xunit-nsubstitute-bce359ba0b74>
- <https://medium.com/@nile.bits/javascript-factory-design-pattern-a-comprehensive-guide-9266b726ee5c>

## Task

- [ ] File Structure
  - [x] MVC
  - [ ] Atomic File Structure
- [ ] Software Patterns
  - [x] Singleton
  - [x] Factory
  - [x] Dependency Injection
  - [x] Adapter
  - [ ] Strategy
  - [ ] Decorator
  - [ ] Iterator
  - [ ] Observer

## Notes

- Use `Singleton` for Global State
- Use `Factory` pattern with `Dependency Injection` pattern
  - Use this when reading from Different Sources of Data
- Use `Adapter` for Different Output
- Use `Observer` for Push Notification, Web Socket
- Use `Iterator` for Faster Looping
- Use `Strategy` for Executing Different Algorithms
- Use `Decorator` to add additional code without modifying original code

From what I understand of the Youtube Video, everything is involved with Dependency Injection

We could use Factory Method to assist with some parts like initialization

For Javascript, there is no need for interface since every object is the same (IDK how to explain, but since there's no type checking, you just need to make sure there is the same function)

strategy pattern is used when we want to change the behavior of the method, but for the same class

Factory Pattern is used when we have same behavior of method, but different objects (think File I/0, Database)

## Definition

### Definition for Gang-Of-Four (GOF)

<table>
	<tr>
		<th>Creational Pattern</th>
		<td>How Objects are created<br/>Focus on Class Instantiation or Object Creation</td>
	</tr>
	<tr>
		<th>Structural Pattern</th>
		<td>How objects related to each other<br/>Focus on How to Handle Data</td>
	</tr>
	<tr>
		<th>Behavioral Pattern</th>
		<td>How Objects communicate with each other<br/>Focus on Communication between of Objects, Sharing Data</td>
	</tr>
</table>

### Definition for Design Patterns

<table>
	<tr>
		<th>Singleton</th>
		<th>Creational</th>
		<td>Ensures a class has only one instance and provides a global point of access to that instance.</td>
	</tr>
	<tr>
		<th>Factory</th>
		<th>Creational</th>
		<td>Provides an interface for creating objects in a superclass but allows subclasses to alter the type of
			created object.</td>
	</tr>
	<tr>
		<th>Dependency Injection</th>
		<th>Behavioral</th>
		<td>Passes dependencies (like objects or functions) as parameters, allowing decoupling and flexibility.</td>
	</tr>
	<tr>
		<th>Observer</th>
		<th>Behavioral</th>
		<td>Defines a one-to-many dependency, where changes in one object notify and update all dependents.</td>
	</tr>
	<tr>
		<th>Strategy</th>
		<th>Behavioral</th>
		<td>Enables selecting an algorithm's behavior at runtime by encapsulating it within different classes.</td>
	</tr>
	<tr>
		<th>Decorator</th>
		<th>Structural</th>
		<td>Adds new functionality to an object dynamically by wrapping it in an object of a decorator class.</td>
	</tr>
	<tr>
		<th>Iterator</th>
		<th>Behavioral</th>
		<td>Provides a way to access elements of a collection without exposing its underlying representation.</td>
	</tr>
	<tr>
		<th>Adapter</th>
		<th>Structural</th>
		<td>Allows incompatible interfaces to work together by converting the interface of a class into another.</td>
	</tr>
	<tr>
		<th>Facade</th>
		<th>Structural</th>
		<td>Simplifies complex systems by providing a unified interface that represents a simplified API.</td>
	</tr>
</table>

## Fun with RSpec series
> Exploring Behaviour-Driven Development with Ruby. Testing what should happen rathen than what will happen.

Please checkout the README files for the details of some RSpec fun. RSpec is a testing tool for the Ruby programming language that
is aligned well to the idea of BDD and story driven development.



1. [Part 1] (https://github.com/mvemjsun/RSpec_fun/blob/master/README_Part_1.md)
	Initial introduction

2. [Part 2] (https://github.com/mvemjsun/RSpec_fun/blob/master/README_Part_2.md)
	More into helper modules, contexts, matchers, expectations and hooks. 
	Uses the observer and singleton pattern in the classes under test.

3. [Part 3] (https://github.com/mvemjsun/RSpec_fun/blob/master/README_Part_3.md)
	Have(n) matcher and "be_" matcher

4. [Part 4] (https://github.com/mvemjsun/RSpec_fun/blob/master/README_Part_4.md)
	Implicit and explicit subject.

5. [Part 5] (https://github.com/mvemjsun/RSpec_fun/blob/master/README_Part_5.md)
	Mocking objects. Stubs, doubles and message expectations

6. [Part 6] (https://github.com/mvemjsun/RSpec_fun/blob/master/README_Part_6.md)
	Custom argument matchers

### Running the tests

#### Install gem for RSpec
`gem install rspec` 

To run the tests do `rake test:part1` or `rake test:part2` and so on.
To run all tests do `rake test:all`

### References

1. [RSpec core] (http://rubydoc.info/gems/rspec-core)
2. [RSpec expectations] (http://rubydoc.info/gems/rspec-expectations)
3. [RSpec mocks] (http://rubydoc.info/gems/rspec-mocks)
4. [RSpec book] (http://pragprog.com/book/achbd/the-rspec-book)
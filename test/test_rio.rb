require 'helper'

class TestRio < Test::Unit::TestCase
	context "Basic functionality" do

		should "be able to evaluate simple Io expressions" do
			RIO.eval do |io|
				assert_equal("Oh hai",
					io.run('"Oh hai"'))
				
				assert_equal("Hello World", io.run(<<-SMALLSNIPPET))
					hello := "Hello"
					world := "World"
					"\#{hello} \#{world}" interpolate
				SMALLSNIPPET

				assert_equal(42,
					io.run('42'))
				
				assert_equal(42,
					io.run('21+21'))
			end
		end

		should "be able to coerce IO Numbers into Ruby Fixnums" do
			RIO.eval do |io|
				io['test_interop_a'] = 42

				assert_equal(Fixnum,
					io.run('getSlot("test_interop_a")').class)

				assert_equal(42,
					io.run('getSlot("test_interop_a")'))
			end
		end

		should "be able to coerce IO Sequences into Ruby strings" do
			RIO.eval do |io|
				io['test_interop_a'] = "this is true"

				assert_equal(String,
					io.run('getSlot("test_interop_a")').class)

				assert_equal(io.run('getSlot("test_interop_a")'),
					"this is true")
			end
		end

		should "be able to share variables between ruby and io" do
			RIO.eval do |io|



			end
		end

		should "be able to share variables between io and ruby" do
			RIO.eval do |io|
				io.run 'test_interop_a := "Oh hai ruby"'
				io.run "test_interop_b := 42"
				assert_equal("Oh hai ruby", 
					io['test_interop_a'])
				
				assert_equal(String, 
					io['test_interop_a'].class)

				assert_equal(42,
					io['test_interop_b'])
				
				assert_equal(Fixnum,
					io['test_interop_b'].class)
			end
		end

  	end
end

require 'helper'

class TestRio < Test::Unit::TestCase
	context "Basic functionality" do

		should "be able to evaluate simple Io expressions" do
			RIO.eval do |io|
				assert_equal(Io.IoSeq_asCString(io.run('"Oh hai"')),
					"Oh hai")
				
				assert_equal(Io.IoSeq_asCString(io.run(<<-SMALLSNIPPET)), "Hello World")
					hello := "Hello"
					world := "World"
					"\#{hello} \#{world}" interpolate
				SMALLSNIPPET

				assert_equal(Io.IoNumber_asInt(io.run('42')),
					42)
				
				assert_equal(Io.IoNumber_asInt(io.run('21+21')),
					42)
			end
		end

		should "be able to share variables between ruby and io" do
			RIO.eval do |io|
				io['test_interop_a'] = "this is true"

				# temp conversion TODO: propper handling
				assert_equal(Io.IoSeq_asCString(io.run('getSlot("test_interop_a")')),
					"this is true")
			end
		end

		should "be able to share variables between io and ruby" do
			RIO.eval do |io|
				io.run 'test_interop_b := "Oh hai ruby"'

				assert_equal(io['test_interop_b'],
					"Oh hai ruby")
			end
		end

  	end
end

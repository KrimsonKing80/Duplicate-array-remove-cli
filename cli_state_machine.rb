class CLIStateMachine
	attr_accessor :state, :stateArray, :callbackFunction

	def initialize( myStateArray, callback)
		@state = 0
		@exitArray = ['exit','quit','x']
		@stateArray = [""]

		if myStateArray.class != Array
			@state = -1
		else
			@stateArray = myStateArray
		end

		if callback.class == Proc
			@callbackFunction = callback
		else
			@callbackFunction = nil
		end
	end

	def stateArray(newArray)
		@stateArray = newArray if newArray.class != Array
	end

	def nextState
		case @state
		when -1
			# do nothing
		when @state >= @stateArray.length
			@state = 0
		else
			@state += 1
		end
	end

	def resetState
		@state = 0
	end

	def getPrompt
		@state = 0 if @state >= @stateArray.length # this is illegal so reset state

		if @state < 0
			retval = ""
		else
			retval = @stateArray[@state]
		end

		return retval
	end

	def checkState?
		@state = 0 if @state >= @stateArray.length
		if @state > -1
			return true
		else
			return false
		end
	end

	def startCLILoop
		loop do
			begin
				if checkState?
					@prompt = @stateArray[@state]
					print "#{@prompt}: "
					inline = gets.chomp
					break if @exitArray.include?(inline.downcase)
					raise RuntimeError.new("Intentional Error for Test") if inline.downcase == 'error'
					@callbackFunction.call(self, inline)
				else
					print 'Illegal state. Press [RETURN] to exit'
					break
				end
			rescue => e
				puts "Exception Class: #{ e.class.name }"
				puts "Exception Message: #{ e.message }"
				puts "Exception Backtrace: #{ e.backtrace }"
				resetState
				puts "State Reset... try again \n"
			end
		end
	end
end
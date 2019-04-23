require 'json'
require '.\duplicates.rb'
require '.\cli_state_machine.rb'

$r = RemoveDuplicatesFromArray.new

$myStateArray = ["Type new array of numbers or press [RETURN] to use Current Array",
				 "Enter debug level or press [RETURN] to use current debug level",
				 "Press [RETURN] to remove duplicates"]

handle_input = Proc.new do |stateMachine, inputLine|
	#puts "State #{$stateHandler.state}. Go to next state."
	#$stateHandler.nextState
	#$stateHandler.resetState
	case $stateHandler.state
	when 0
		#puts "Entered: #{inputLine}"
		if inputLine.length > 0
			if inputLine[0] != '[' or inputLine[-1] != ']'
				inputLine = '[' + inputLine + ']'
			end
			$r.workingList = JSON.parse(inputLine.gsub("'",'"'))
			puts "New array is #{$r.workingList}"
		else
			puts "Current array is #{$r.workingList}"
		end
		stateMachine.nextState
	when 1
		#puts "Entered: #{inputLine}"
		if inputLine.to_i.to_s == inputLine
			$r.debugLevel = inputLine.to_i
		end
		$stateHandler.nextState
	when 2
		$r.remove
		puts "Final array is #{$r.workingList}"
		$stateHandler.nextState
	else
		$stateHandler.resetState
	end
end

$stateHandler = CLIStateMachine.new($myStateArray, handle_input)

puts "Remove duplicates from an array"
puts "Initial array is #{$r.workingList}"
puts "Enter 'exit' or 'quit' to terminate.\n"

puts 'state machine test'
$stateHandler.startCLILoop
# Ruby project 1 - eliminate duplicates in list

class RemoveDuplicatesFromArray
  attr_accessor :workingList, :debugLevel
  @@mylist = [1, 2, 3, 2]
  def initialize(startingList = @@mylist, debug = 1)
    @workingList = (startingList.class.name == 'Array') ? startingList.clone : @@mylist.clone

    @debugLevel = debug
    @startIndex = 0
    debugPrint(1, "initial array: #{@workingList}")
    @lastIndex = @workingList.length - 1
  end

  def debugPrint(level, text)
    puts text if level <= @debugLevel
  end

  def remove # remove duplicates
    debugPrint(3, 'enter method r')
    while @startIndex < @lastIndex
      debugPrint(3, "start index = #{@startIndex}, last index = #{@lastIndex}")
      removeDuplicatesFromIndex(@startIndex)
      @startIndex += 1
      @lastIndex = @workingList.length - 1
      debugPrint(2, "current array: #{@workingList}")
    end

    debugPrint(1, "final array: #{@workingList}")
  end

  def removeDuplicatesFromIndex(starti)
    first = @workingList[starti]
    debugPrint(3, "first element at starti is #{@workingList[starti]}")
    i = starti + 1
    while i <= (@workingList.length - 1)
      debugPrint(3, "element at i is #{@workingList[i]}")
      if first == @workingList[i]
        debugPrint(3, "remove element at #{i}")
        @workingList.delete_at(i)
	  else
		  i += 1
	  end
    end
  end
end

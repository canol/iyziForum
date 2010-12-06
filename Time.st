Time extend [
	<category: 'IyziForum'>
	<comment: nil>
	
	printFormatted: aFormat language: aLanguage [
		| hour minute second formattedString |
		
		<category: 'printing'>
		
		(self hour printString size = 1)
			ifTrue: [
				hour := '0', self hour printString]
			ifFalse: [
				hour := self hour printString].
				
		(self minute printString size = 1)
			ifTrue: [
				minute := '0', self minute printString]
			ifFalse: [
				minute := self minute printString].
				
		(self second printString size = 1)
			ifTrue: [
				second := '0', self second printString]
			ifFalse: [
				second := self second printString].
			
		formattedString := aFormat copyReplacingAllRegex: 'HH' with: hour.
		formattedString := formattedString copyReplacingAllRegex: 'MM' with: minute.
		formattedString := formattedString copyReplacingAllRegex: 'SS' with: second.
		
		^formattedString
	]
]

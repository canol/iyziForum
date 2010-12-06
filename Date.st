Date extend [
	<category: 'IyziForum'>
	<comment: nil>
	
	printFormatted: aFormat language: aLanguage [
		| formattedString |
		
		<category: 'printing'>
		
		formattedString := aFormat copyReplacingAllRegex: 'YY' with: self year printString.
		formattedString := formattedString copyReplacingAllRegex: 'MMM' with: (aLanguage translate: self monthName asString).
		formattedString := formattedString copyReplacingAllRegex: 'MM' with: self month printString.
		formattedString := formattedString copyReplacingAllRegex: 'DD' with: self day printString.
		
		^formattedString
	]
]

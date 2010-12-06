DateTime extend [
	<category: 'IyziForum'>
	<comment: nil>
	
	printFormatted: aDateFormat withTimeFormat: aTimeFormat language: aLanguage [
		| formattedString |
		
		<category: 'printing'>
		
		formattedString := (self asDate printFormatted: aDateFormat language: aLanguage), ' ', (self asTime printFormatted: aTimeFormat language: aLanguage).
		
		^formattedString
	]
]

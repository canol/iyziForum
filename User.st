Object subclass: User [
	| ip |
	
	<category: 'IyziForum'>
	<comment: nil>

	ip [
		<category: 'accessing'>
		
		^ip
	]
	
	ip: aString [
		<category: 'accessing'>
		
		ip := aString.
	]
	
	loggedIn [
		<category: 'testing'>
		
		^self subclassResponsibility
	]
	
	remember [
		<category: 'testing'>
		
		^self subclassResponsibility
	]
]

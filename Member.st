User subclass: Member [
	| memberName password emailAddress hideEmail registrationDateTime lastPresenceDateTime remember |
	
	<category: 'IyziForum'>
	<comment: nil>
	
	Member class >> new [
		<category: 'instance creation'>
		
		^self basicNew
			initialize;
			yourself
	]
	
	initialize [
		<category: 'initialization'>
		
		self memberName: ''.
		self password: ''.
		self emailAddress: ''.
		self hideEmail: true.
		self registrationDateTime: DateTime now.
		self lastPresenceDateTime: DateTime now.
		self remember: false.
	]

	memberName [
		<category: 'accessing'>
		
		^memberName
	]
	
	memberName: aString [
		<category: 'accessing'>
		
		memberName := aString.
	]

	password [
		<category: 'accessing'>
		
		^password
	]
	
	password: aString [
		<category: 'accessing'>
		
		password := aString.
	]

	emailAddress [
		<category: 'accessing'>
		
		^emailAddress
	]
	
	emailAddress: aString [
		<category: 'accessing'>
		
		emailAddress := aString.
	]

	hideEmail [
		<category: 'accessing'>
		
		^hideEmail
	]
	
	hideEmail: aBoolean [
		<category: 'accessing'>
		
		hideEmail := aBoolean.
	]

	registrationDateTime [
		<category: 'accessing'>
		
		^registrationDateTime
	]
	
	registrationDateTime: aDateTime [
		<category: 'accessing'>
		
		registrationDateTime := aDateTime.
	]

	lastPresenceDateTime [
		<category: 'accessing'>
		
		^lastPresenceDateTime
	]
	
	lastPresenceDateTime: aDateTime [
		<category: 'accessing'>
		
		lastPresenceDateTime := aDateTime.
	]
	
	loggedIn [
		<category: 'testing'>
		
		^true
	]

	remember [
		<category: 'accessing'>
		
		^remember
	]
	
	remember: aString [
		<category: 'accessing'>
		
		remember := aString.
	]
]

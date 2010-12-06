Object subclass: Post [
	| parentPost subject message member dateTime lastReply membersWhoReadAllTheMessages ip |
	
	<category: 'IyziForum'>
	<comment: nil>
	
	Post class >> new [
		<category: 'instance creation'>
		
		^self basicNew
			initialize;
			yourself
	]
	
	initialize [
		<category: 'initialization'>
		
		self subject: ''.
		self message: ''.
		self dateTime: DateTime now.
		self membersWhoReadAllTheMessages: Set new.
		self ip: ''.
	]
	
	id: anOrderedCollection [
		<category: 'accessing'>
		
		^anOrderedCollection indexOf: self
	]
	
	parentPost [
		<category: 'accessing'>
		
		^parentPost
	]
	
	parentPost: aPost [
		<category: 'accessing'>
		
		parentPost := aPost.
	]
	
	subject [
		<category: 'accessing'>
		
		^subject
	]
	
	subject: aString [
		<category: 'accessing'>
		
		subject := aString.
	]
	
	message [
		<category: 'accessing'>
		
		^message
	]
	
	message: aString [
		<category: 'accessing'>
		
		message := aString.
	]
	
	member [
		<category: 'accessing'>
		
		^member
	]
	
	member: aMember [
		<category: 'accessing'>
		
		member := aMember.
	]
	
	dateTime [
		<category: 'accessing'>
		
		^dateTime
	]
	
	dateTime: aDateTime [
		<category: 'accessing'>
		
		dateTime := aDateTime.
	]
	
	lastReply [
		<category: 'accessing'>
		
		^lastReply
	]
	
	lastReply: aPost [
		<category: 'accessing'>
		
		lastReply := aPost.
	]
	
	membersWhoReadAllTheMessages [
		<category: 'accessing'>
		
		^membersWhoReadAllTheMessages
	]
	
	membersWhoReadAllTheMessages: aSet [
		<category: 'accessing'>
		
		membersWhoReadAllTheMessages := aSet.
	]
	
	ip [
		<category: 'accessing'>
		
		^ip
	]
	
	ip: aString [
		<category: 'accessing'>
		
		ip := aString.
	]
]

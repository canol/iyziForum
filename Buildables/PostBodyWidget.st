Iliad.ILWidget subclass: PostBodyWidget [
	| post |
	
	<category: 'IyziForum-Buildables'>
	<comment: nil>
	
	initialize [
		<category: 'initialization'>
		
		super initialize.
		
		self post: Post new.
	]
	
	post [
		<category: 'accessing'>
		
		^post
	]
	
	post: aPost [
		<category: 'accessing'>
		
		post := aPost.
	]
	
	contents [
		<category: 'building'>
		
		^[:e |
			| postBodyClass |
			
			((self application isAdmin: self application user) or: [post member = self application user])
				ifTrue: [
					postBodyClass := 'Body Editable']
				ifFalse: [
					postBodyClass := 'Body'].
			
			e div
				class: postBodyClass;
				build: [:div |
					| parsedMessage |
					
					parsedMessage := self post message tokenize: Character nl asString.
					
					parsedMessage
						do: [:each |
							div text: each]
						separatedBy: [
							div br]]]
	]
]

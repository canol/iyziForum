Object subclass: Language [
	| forumVersion languageName translations |
	
	<shape: #inherit> 
	<category: 'IyziForum'>
	<comment: nil>
	
	Language class >> new [
		<category: 'intance creation'>
		
		^self basicNew
			initialize;
			yourself
	]
	
	initialize [
		<category: 'initialization'>
		
		self
			forumVersion: '0.1';
			languageName: 'English';
			translations: Dictionary new.
			
		translations
			at: 'Admin' put: 'Admin';
			at: 'Admin Information' put: 'Admin Information';
			at: 'Admin Panel' put: 'Admin Panel';
			at: 'April' put: 'April';
			at: 'Are you sure you want to delete this member?' put: 'Are you sure you want to delete this member?';
			at: 'Are you sure you want to log out?' put: 'Are you sure you want to log out?';
			at: 'August' put: 'August';
			at: 'Cancel' put: 'Cancel';
			at: 'December' put: 'December';
			at: 'Delete Member' put: 'Delete Member';
			at: 'Edit Member Details' put: 'Edit Member Details';
			at: 'Email' put: 'Email';
			at: 'Email Address:' put: 'Email Address:';
			at: 'February' put: 'February';
			at: 'Hidden' put: 'Hidden';
			at: 'January' put: 'January';
			at: 'July' put: 'July';
			at: 'June' put: 'June';
			at: 'Last Here On:' put: 'Last Here On:';
			at: 'Login' put: 'Login';
			at: 'Logout' put: 'Logout';
			at: 'Main Page' put: 'Main Page';
			at: 'March' put: 'March';
			at: 'May' put: 'May';
			at: 'Member' put: 'Member';
			at: 'Member Details' put: 'Member Details';
			at: 'Member Name:' put: 'Member Name:';
			at: 'Members' put: 'Members';
			at: 'Membership Deleted' put: 'Membership Deleted';
			at: 'Moderator' put: 'Moderator';
			at: 'My Details' put: 'My Details';
			at: 'Name, Lastname' put: 'Name, Lastname';
			at: 'New Password:' put: 'New Password:';
			at: 'New Password Again:' put: 'New Password Again:';
			at: 'New Post' put: 'New Post';
			at: 'Next' put: 'Next';
			at: 'No' put: 'No';
			at: 'No member specified.' put: 'No member specified.';
			at: 'No Reply Yet' put: 'No Reply Yet';
			at: 'No New Post' put: 'No New Post';
			at: 'November' put: 'November';
			at: 'October' put: 'October';
			at: 'Okay' put: 'Okay';
			at: 'Only members can see the detailed information of other members.' put: 'Only members can see the detailed information of other members.';
			at: 'Password:' put: 'Password:';
			at: 'Password Again:' put: 'Password Again:';
			at: 'Please don''t forget to fill in the password twice.' put: 'Please don''t forget to fill in the password twice.';
			at: 'Please fill in the information of the first admin you want to create for this forum.' put: 'Please fill in the information of the first admin you want to create for this forum.';
			at: 'Post Count:' put: 'Post Count:';
			at: 'Post New Topic' put: 'Post New Topic';
			at: 'Question:' put: 'Question:';
			at: 'Re: {Subject}' put: 'Re: {Subject}';
			at: 'Register' put: 'Register';
			at: 'Registered On:' put: 'Registered On:';
			at: 'Remember me' put: 'Remember me';
			at: 'Reply' put: 'Reply';
			at: 'Save' put: 'Save';
			at: 'Search' put: 'Search';
			at: 'Secret Answer:' put: 'Secret Answer:';
			at: 'Send' put: 'Send';
			at: 'September' put: 'September';
			at: 'Setup' put: 'Setup';
			at: 'Succesfully saved the member details.' put: 'Succesfully saved the member details.';
			at: 'The email address you entered has already been registered. Please enter another email address or contact the forum admin via {EmailAddress} email address.' put: 'The email address you entered has already been registered. Please enter another email address or contact the forum admin via {EmailAddress} email address.';
			at: 'The member name cannot be longer than {MaxMemberNameCharacterCount} characters.' put: 'The member name cannot be longer than {MaxMemberNameCharacterCount} characters.';
			at: 'The member name cannot be shorter than {MinMemberNameCharacterCount} characters.' put: 'The member name cannot be shorter than {MinMemberNameCharacterCount} characters.';
			at: 'The member name you have chosen has already been registered. Please choose another member name.' put: 'The member name you have chosen has already been registered. Please choose another member name.';
			at: 'The message cannot be longer than {MaxMessageCharacterCount} characters.' put: 'The message cannot be longer than {MaxMessageCharacterCount} characters.';
			at: 'The message cannot be shorter than {MinMessageCharacterCount} characters.' put: 'The message cannot be shorter than {MinMessageCharacterCount} characters.';
			at: 'The password cannot be shorter than {MinPasswordCharacterCount} characters.' put: 'The password cannot be shorter than {MinPasswordCharacterCount} characters.';
			at: 'The passwords you entered do not match.' put: 'The passwords you entered do not match.';
			at: 'The subject cannot be longer than {MaxSubjectCharacterCount} characters.' put: 'The subject cannot be longer than {MaxSubjectCharacterCount} characters.';
			at: 'The subject cannot be shorter than {MinSubjectCharacterCount} characters.' put: 'The subject cannot be shorter than {MinSubjectCharacterCount} characters.';
			at: 'There are currently no pending members.' put: 'There are currently no pending members.';
			at: 'There are no members registered on this forum. Please register the first member -who will become an admin of the forum- via the menu above.' put: 'There are no members registered on this forum. Please register the first member -who will become an admin of the forum- via the menu above.';
			at: 'There are no members yet.' put: 'There are no members yet.';
			at: 'There are no topics yet.' put: 'There are no topics yet.';
			at: 'This question will be used to give you a new password if you forget your current one.' put: 'This question will be used to give you a new password if you forget your current one.';
			at: 'Welcome visitor!' put: 'Welcome visitor!';
			at: 'Yes' put: 'Yes';
			at: 'You cannot leave the email address empty.' put: 'You cannot leave the email address empty.';
			at: 'You cannot leave the member name empty.' put: 'You cannot leave the member name empty.';
			at: 'You cannot leave the message empty.' put: 'You cannot leave the message empty.';
			at: 'You cannot leave the password empty.' put: 'You cannot leave the password empty.';
			at: 'You cannot leave the question empty.' put: 'You cannot leave the question empty.';
			at: 'You cannot leave the secret answer empty.' put: 'You cannot leave the secret answer empty.';
			at: 'You cannot leave the subject empty.' put: 'You cannot leave the subject empty.';
			at: 'You don''t have permission to edit these details.' put: 'You don''t have permission to edit these details.';
			at: 'You entered a wrong member name or a member with this member name is not registered.' put: 'You entered a wrong member name or a member with this member name is not registered.';
			at: 'You entered a wrong password.' put: 'You entered a wrong password.';
			at: 'You should first login to edit member details.' put: 'You should first login to edit member details.'.
	]
	
	forumVersion [
		<category: 'accessing'>
		
		^forumVersion
	]
	
	forumVersion: aString [
		<category: 'accessing'>
		
		forumVersion := aString.
	]
	
	languageName [
		<category: 'accessing'>
		
		^languageName
	]
	
	languageName: aString [
		<category: 'accessing'>
		
		languageName := aString.
	]
	
	translations [
		<category: 'accessing'>
		
		^translations
	]
	
	translations: aDictionary [
		<category: 'accessing'>
		
		translations := aDictionary.
	]
	
	translate: aString [
		<category: 'actions'>
		
		^self translations at: aString ifAbsent: [^'No translations available']
	]
]

Extension { #name : #RubAbstractTextArea }

{ #category : #'*Phanide-Browser' }
RubAbstractTextArea >> handleKeystroke: anEvent [ 
	"System level event handling."

	anEvent wasHandled
		ifTrue: [^ self].

	"Black list the arrows for spec."
	(self allowsKeymapping and: [({Character arrowLeft . Character arrowRight} includes: anEvent keyCharacter) not])
		ifTrue: [
			(anEvent keyCharacter = Character tab and: [self valueOfProperty: #processTabHere ifAbsent: [ false ]]) ifFalse: [ 
				self dispatchKeystrokeForEvent: anEvent
			]
	] .
	anEvent wasHandled
		ifTrue: [
			"We need to check for completion here because otherwise it will try to handle the keystroke, 
			even if it was already processed."
			(Smalltalk tools hasToolNamed: #codeCompletion) 
				ifTrue: [ Smalltalk tools codeCompletion uniqueInstance closeMenu ].
			^ self].
	(self handlesKeyStroke: anEvent)
		ifFalse: [^ self].
	self keyStroke: anEvent.
	anEvent wasHandled: true.
]

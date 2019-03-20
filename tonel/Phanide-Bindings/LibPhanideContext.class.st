Class {
	#name : #LibPhanideContext,
	#superclass : #LibPhanideHandle,
	#category : 'Phanide-Bindings-Bindings'
}

{ #category : #operations }
LibPhanideContext class >> create [
	^ self create: 0
]

{ #category : #operations }
LibPhanideContext class >> create: semaphoreIndex [
	^ self ffiCall: #(phanide_context_t phanide_createContext(size_t semaphoreIndex))
]

{ #category : #initialize }
LibPhanideContext >> destroy [
	^ self ffiCall: #(void phanide_destroyContext(this))
]

{ #category : #initialization }
LibPhanideContext >> initialize [ 
	handle value = 0 ifTrue: [ 
		self error: 'Error creating new context' ].
	FFIExternalResourceManager addResource: self data: handle
]

{ #category : #events }
LibPhanideContext >> pollEvent: anEvent [
	^ self ffiCall: #(bool phanide_pollEvent(self, phanide_event_t *anEvent))
]

{ #category : #events }
LibPhanideContext >> pushEvent: anEvent [
	^ self ffiCall: #(int phanide_pushEvent(self, phanide_event_t *anEvent))
]

{ #category : #process }
LibPhanideContext >> spawn: path arguments: arguments [
	^ self ffiCall: #(phanide_process_t phanide_process_spawnInPath(self, String path, String* arguments))
]

{ #category : #process }
LibPhanideContext >> spawnInPath: file arguments: arguments [
	^ self ffiCall: #(phanide_process_t phanide_process_spawnInPath(self, String file, String* arguments))
]

{ #category : #process }
LibPhanideContext >> spawnShell: command [
	^ self ffiCall: #(phanide_process_t phanide_process_spawnShell(self, String command))
]

{ #category : #events }
LibPhanideContext >> waitEvent: anEvent [
	^ self ffiCall: #(bool phanide_waitEvent(self, phanide_event_t *anEvent))
]

{ #category : #'file system' }
LibPhanideContext >> watchDirectory: path [
	^ self ffiCall: #(phanide_fsmonitor_handle_t phanide_fsmonitor_watchFile(self, String path))
]

{ #category : #'file system' }
LibPhanideContext >> watchFile: path [
	^ self ffiCall: #(phanide_fsmonitor_handle_t phanide_fsmonitor_watchFile(self, String path))
]
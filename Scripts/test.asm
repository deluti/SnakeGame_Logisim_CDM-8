asect 0x00

start:
	ldi r0, OUT
	ld r0, r0
	
	ldi r1, a
	ld r1, r1
	
	ldi r2, b
	ld r2, r2
	
	add r2, r1
	
	ldi r3, a
	
	st r3, r1	
	st r0, r1
	br start
	
a: dc 01
b: dc 01
OUT: dc 0x00

end
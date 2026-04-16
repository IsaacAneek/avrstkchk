
avr-playground.elf:     file format elf32-avr


Disassembly of section .text:

00000000 <__vectors>:
   0:	0c 94 34 00 	jmp	0x68	; 0x68 <__ctors_end>
   4:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
   8:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
   c:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  10:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  14:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  18:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  1c:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  20:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  24:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  28:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  2c:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  30:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  34:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  38:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  3c:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  40:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  44:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  48:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  4c:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  50:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  54:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  58:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  5c:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  60:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  64:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>

00000068 <__ctors_end>:
  68:	11 24       	eor	r1, r1
  6a:	1f be       	out	0x3f, r1	; 63
  6c:	cf ef       	ldi	r28, 0xFF	; 255
  6e:	d8 e0       	ldi	r29, 0x08	; 8
  70:	de bf       	out	0x3e, r29	; 62
  72:	cd bf       	out	0x3d, r28	; 61
  74:	0e 94 85 00 	call	0x10a	; 0x10a <main>
  78:	0c 94 93 00 	jmp	0x126	; 0x126 <_exit>

0000007c <__bad_interrupt>:
  7c:	0c 94 00 00 	jmp	0	; 0x0 <__vectors>

00000080 <bar>:
  80:	cf 93       	push	r28
  82:	df 93       	push	r29
  84:	cd b7       	in	r28, 0x3d	; 61
  86:	de b7       	in	r29, 0x3e	; 62
  88:	c4 56       	subi	r28, 0x64	; 100
  8a:	d1 09       	sbc	r29, r1
  8c:	0f b6       	in	r0, 0x3f	; 63
  8e:	f8 94       	cli
  90:	de bf       	out	0x3e, r29	; 62
  92:	0f be       	out	0x3f, r0	; 63
  94:	cd bf       	out	0x3d, r28	; 61
  96:	80 e0       	ldi	r24, 0x00	; 0
  98:	90 e0       	ldi	r25, 0x00	; 0

0000009a <.L2>:
  9a:	fe 01       	movw	r30, r28
  9c:	31 96       	adiw	r30, 0x01	; 1
  9e:	e8 0f       	add	r30, r24
  a0:	f9 1f       	adc	r31, r25
  a2:	80 83       	st	Z, r24
  a4:	01 96       	adiw	r24, 0x01	; 1
  a6:	84 36       	cpi	r24, 0x64	; 100
  a8:	91 05       	cpc	r25, r1
  aa:	b9 f7       	brne	.-18     	; 0x9a <.L2>
  ac:	8e 81       	ldd	r24, Y+6	; 0x06
  ae:	cc 59       	subi	r28, 0x9C	; 156
  b0:	df 4f       	sbci	r29, 0xFF	; 255
  b2:	0f b6       	in	r0, 0x3f	; 63
  b4:	f8 94       	cli
  b6:	de bf       	out	0x3e, r29	; 62
  b8:	0f be       	out	0x3f, r0	; 63
  ba:	cd bf       	out	0x3d, r28	; 61
  bc:	df 91       	pop	r29
  be:	cf 91       	pop	r28
  c0:	08 95       	ret

000000c2 <foo>:
  c2:	cf 93       	push	r28
  c4:	df 93       	push	r29
  c6:	cd b7       	in	r28, 0x3d	; 61
  c8:	de b7       	in	r29, 0x3e	; 62
  ca:	c4 56       	subi	r28, 0x64	; 100
  cc:	d1 09       	sbc	r29, r1
  ce:	0f b6       	in	r0, 0x3f	; 63
  d0:	f8 94       	cli
  d2:	de bf       	out	0x3e, r29	; 62
  d4:	0f be       	out	0x3f, r0	; 63
  d6:	cd bf       	out	0x3d, r28	; 61
  d8:	80 e0       	ldi	r24, 0x00	; 0
  da:	90 e0       	ldi	r25, 0x00	; 0

000000dc <.L5>:
  dc:	fe 01       	movw	r30, r28
  de:	31 96       	adiw	r30, 0x01	; 1
  e0:	e8 0f       	add	r30, r24
  e2:	f9 1f       	adc	r31, r25
  e4:	80 83       	st	Z, r24
  e6:	01 96       	adiw	r24, 0x01	; 1
  e8:	84 36       	cpi	r24, 0x64	; 100
  ea:	91 05       	cpc	r25, r1
  ec:	b9 f7       	brne	.-18     	; 0xdc <.L5>
  ee:	0e 94 40 00 	call	0x80	; 0x80 <bar>
  f2:	8e 83       	std	Y+6, r24	; 0x06
  f4:	8e 81       	ldd	r24, Y+6	; 0x06
  f6:	cc 59       	subi	r28, 0x9C	; 156
  f8:	df 4f       	sbci	r29, 0xFF	; 255
  fa:	0f b6       	in	r0, 0x3f	; 63
  fc:	f8 94       	cli
  fe:	de bf       	out	0x3e, r29	; 62
 100:	0f be       	out	0x3f, r0	; 63
 102:	cd bf       	out	0x3d, r28	; 61
 104:	df 91       	pop	r29
 106:	cf 91       	pop	r28
 108:	08 95       	ret

0000010a <main>:
 10a:	00 d0       	rcall	.+0      	; 0x10c <L0^A>

0000010c <L0^A>:
 10c:	cd b7       	in	r28, 0x3d	; 61
 10e:	de b7       	in	r29, 0x3e	; 62
 110:	0e 94 61 00 	call	0xc2	; 0xc2 <foo>
 114:	90 e0       	ldi	r25, 0x00	; 0
 116:	9a 83       	std	Y+2, r25	; 0x02
 118:	89 83       	std	Y+1, r24	; 0x01
 11a:	89 81       	ldd	r24, Y+1	; 0x01
 11c:	9a 81       	ldd	r25, Y+2	; 0x02
 11e:	01 96       	adiw	r24, 0x01	; 1
 120:	9a 83       	std	Y+2, r25	; 0x02
 122:	89 83       	std	Y+1, r24	; 0x01

00000124 <.L8>:
 124:	ff cf       	rjmp	.-2      	; 0x124 <.L8>

00000126 <_exit>:
 126:	f8 94       	cli

00000128 <__stop_program>:
 128:	ff cf       	rjmp	.-2      	; 0x128 <__stop_program>

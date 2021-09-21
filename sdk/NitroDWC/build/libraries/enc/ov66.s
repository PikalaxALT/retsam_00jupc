	.include "macros.inc"
	.include "global.inc"
	.section .text
	.balign 4, 0

	arm_func_start b64size
b64size: // 0x02257C4C
	ldr r1, _02257C80 // =0xAAAAAAAB
	mov r3, #3
	umull r1, r2, r0, r1
	mov r2, r2, lsr #1
	umull r1, r2, r3, r2
	subs r2, r0, r1
	ldr r1, _02257C80 // =0xAAAAAAAB
	movne r3, #1
	umull r1, r2, r0, r1
	moveq r3, #0
	add r0, r3, r2, lsr #1
	mov r0, r0, lsl #2
	bx lr
	.align 2, 0
_02257C80: .word 0xAAAAAAAB
	arm_func_end b64size

	arm_func_start my_randinit
my_randinit: // 0x02257C84
	ldr r1, _02257C94 // =s_local_seed
	orr r0, r0, r0, lsl #16
	str r0, [r1]
	bx lr
	.align 2, 0
_02257C94: .word s_local_seed
	arm_func_end my_randinit

	arm_func_start my_rand
my_rand: // 0x02257C98
	stmfd sp!, {r3, lr}
	ldr r1, _02257CD0 // =DWCi_ENC_URL_BASE
	ldr r0, _02257CD4 // =s_local_seed
	ldr r3, [r1, #0x48]
	ldr r2, [r1, #0x44]
	ldr r0, [r0]
	ldr r1, [r1, #0x4c]
	mla r0, r2, r0, r3
	bl _u32_div_f
	ldr r0, _02257CD4 // =s_local_seed
	mov r2, r1, asr #0x10
	str r1, [r0]
	and r0, r2, #0xff
	ldmia sp!, {r3, pc}
	.align 2, 0
_02257CD0: .word DWCi_ENC_URL_BASE
_02257CD4: .word s_local_seed
	arm_func_end my_rand

	arm_func_start DWCi_EncValidateKey
DWCi_EncValidateKey: // 0x02257CD8
	stmfd sp!, {r4, r5, r6, r7, r8, lr}
	ldr r4, _02257DC8 // =DWCi_ENC_URL_BASE
	mov ip, #0
	str ip, [r4, #0xc]
	ldr r4, [sp, #0x18]
	mov r8, r0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	bl strlen
	cmp r0, #0x20
	movhs r0, #0
	ldmhsia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, r7
	bl strlen
	cmp r0, #0x14
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	sub r0, r6, #5
	tst r0, #7
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	tst r5, #1
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r2, #0
	mov r1, r2
_02257D44:
	mov r0, r4, lsr r1
	and r0, r0, #1
	cmp r0, #1
	add r1, r1, #1
	addeq r2, r2, #1
	cmp r1, #0x20
	blt _02257D44
	cmp r2, #1
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, _02257DCC // =g_session+0xc
	mov r1, r8
	mov r2, #0x20
	bl strncpy
	ldr r3, _02257DD0 // =g_session+0x2c
	mov r2, #0xa
_02257D84:
	ldrb r1, [r7]
	ldrb r0, [r7, #1]
	add r7, r7, #2
	subs r2, r2, #1
	strb r1, [r3]
	strb r0, [r3, #1]
	add r3, r3, #2
	bne _02257D84
	ldr r1, _02257DC8 // =DWCi_ENC_URL_BASE
	ldr r0, [sp, #0x1c]
	str r6, [r1, #0x44]
	str r5, [r1, #0x48]
	str r4, [r1, #0x4c]
	str r0, [r1, #0x50]
	mov r0, #1
	str r0, [r1, #0xc]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02257DC8: .word DWCi_ENC_URL_BASE
_02257DCC: .word g_session+0xc
_02257DD0: .word g_session+0x2c
	arm_func_end DWCi_EncValidateKey

	arm_func_start DWCi_EncSessionValidateResponse
DWCi_EncSessionValidateResponse: // 0x02257DD4
	stmfd sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x50
	ldr r4, _02257F78 // =rodata_ov66_2258CE4
	add r3, sp, #0
	mov r6, r0
	mov r5, r1
	mov r2, #8
_02257DF0:
	ldrb r1, [r4]
	ldrb r0, [r4, #1]
	add r4, r4, #2
	strb r1, [r3]
	strb r0, [r3, #1]
	add r3, r3, #2
	subs r2, r2, #1
	bne _02257DF0
	ldrb r0, [r4]
	cmp r5, #0x28
	addle sp, sp, #0x50
	strb r0, [r3]
	movle r0, #0
	ldmleia sp!, {r4, r5, r6, r7, r8, pc}
	sub r4, r5, #0x28
	mov r0, r4
	bl b64size
	add r1, r0, #0x29
	mov r0, #7
	bl DWC_Alloc
	movs r7, r0
	addeq sp, sp, #0x50
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r8, _02257F7C // =g_session+0x2c
	mov r3, r7
	mov r2, #0xa
_02257E5C:
	ldrb r1, [r8]
	ldrb r0, [r8, #1]
	add r8, r8, #2
	subs r2, r2, #1
	strb r1, [r3]
	strb r0, [r3, #1]
	add r3, r3, #2
	bne _02257E5C
	mov r0, r6
	mov r2, r4
	add r1, r7, #0x14
	mov r3, #2
	bl B64Encode
	mov r0, r4
	bl b64size
	add r1, r7, #0x14
	ldr r3, _02257F7C // =g_session+0x2c
	add r8, r1, r0
	mov r2, #0xa
_02257EA8:
	ldrb r1, [r3]
	ldrb r0, [r3, #1]
	add r3, r3, #2
	subs r2, r2, #1
	strb r1, [r8]
	strb r0, [r8, #1]
	add r8, r8, #2
	bne _02257EA8
	mov r0, r4
	bl b64size
	mov r2, r0
	add r0, sp, #0x11
	mov r1, r7
	add r2, r2, #0x28
	bl MATH_CalcSHA1
	mov r1, r7
	mov r0, #7
	mov r2, #0
	bl DWC_Free
	mov r2, #0
	add r3, sp, #0x11
	mov r7, r2
	add r1, sp, #0x25
	add r8, sp, #0
_02257F08:
	ldrb ip, [r3], #1
	add r2, r2, #1
	add r0, r1, r7
	mov lr, ip, asr #4
	and ip, ip, #0xf
	ldrsb lr, [r8, lr]
	ldrsb ip, [r8, ip]
	cmp r2, #0x14
	strb lr, [r1, r7]
	strb ip, [r0, #1]
	add r7, r7, #2
	blt _02257F08
	sub r0, r5, #0x28
	mov r3, #0
	add r0, r6, r0
	mov r2, #0x28
	strb r3, [sp, #0x4d]
	bl strncmp
	cmp r0, #0
	addne sp, sp, #0x50
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r1, _02257F80 // =DWCi_ENC_URL_BASE
	mov r0, #1
	str r6, [r1, #0x68]
	str r4, [r1, #0x6c]
	add sp, sp, #0x50
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02257F78: .word rodata_ov66_2258CE4
_02257F7C: .word g_session+0x2c
_02257F80: .word DWCi_ENC_URL_BASE
	arm_func_end DWCi_EncSessionValidateResponse

	arm_func_start DWCi_EncSessionProgressCallback
DWCi_EncSessionProgressCallback: // 0x02257F84
	bx lr
	arm_func_end DWCi_EncSessionProgressCallback

	arm_func_start DWCi_EncSessionCompleteCallback
DWCi_EncSessionCompleteCallback: // 0x02257F88
	stmfd sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x48
	ldr r3, _022581D8 // =DWCi_ENC_URL_BASE
	mvn r4, #0
	str r4, [r3, #8]
	ldr ip, [r3]
	mov r5, r0
	cmp ip, #1
	mov r4, r1
	addeq sp, sp, #0x48
	ldmeqia sp!, {r3, r4, r5, pc}
	cmp r2, #0
	bne _022581CC
	cmp ip, #5
	beq _02257FD4
	cmp ip, #7
	beq _022580FC
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, pc}
_02257FD4:
	cmp r4, #0x20
	bne _022580E8
	ldr r0, [r3, #0x58]
	ldr r3, _022581DC // =rodata_ov66_2258CF5
	add lr, sp, #0
	add r4, r0, #0x14
	mov r2, #8
_02257FF0:
	ldrb r1, [r3]
	ldrb r0, [r3, #1]
	add r3, r3, #2
	strb r1, [lr]
	strb r0, [lr, #1]
	add lr, lr, #2
	subs r2, r2, #1
	bne _02257FF0
	ldrb r0, [r3]
	ldr r3, _022581E0 // =g_session+0x2c
	add ip, sp, #0x11
	strb r0, [lr]
	mov r2, #0xa
_02258024:
	ldrb r1, [r3]
	ldrb r0, [r3, #1]
	add r3, r3, #2
	strb r1, [ip]
	strb r0, [ip, #1]
	add ip, ip, #2
	subs r2, r2, #1
	bne _02258024
	add r0, sp, #0x25
	mov r1, r5
	mov r2, #0x20
	bl memcpy
	add r1, sp, #0x11
	mov r0, r4
	mov r2, #0x34
	bl MATH_CalcSHA1
	mov r0, #0
	ldr r2, _022581D8 // =DWCi_ENC_URL_BASE
	mov r1, r0
	add lr, sp, #0
_02258074:
	ldrb ip, [r4, r0]
	ldr r3, [r2, #0x58]
	mov ip, ip, asr #4
	ldrsb ip, [lr, ip]
	strb ip, [r3, r1]
	ldrb ip, [r4, r0]
	ldr r3, [r2, #0x58]
	add r0, r0, #1
	and ip, ip, #0xf
	ldrsb ip, [lr, ip]
	add r3, r3, r1
	cmp r0, #0x14
	strb ip, [r3, #1]
	add r1, r1, #2
	blt _02258074
	ldr r0, _022581E4 // =data_ov66_225B5CC
	bl strlen
	ldr r1, _022581D8 // =DWCi_ENC_URL_BASE
	mov r4, #0x26
	ldr r3, [r1, #0x58]
	mov r2, #0x29
	strb r4, [r3, -r0]
	ldr r1, [r1, #0x58]
	ldr r0, _022581E8 // =g_session+0x70
	bl strncpy
	ldr r0, _022581D8 // =DWCi_ENC_URL_BASE
	mov r1, #6
	str r1, [r0]
	b _022580EC
_022580E8:
	bl libdwcenc_22584B8
_022580EC:
	mov r0, r5
	bl DWCi_GsFree
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, pc}
_022580FC:
	ldr r0, _022581EC // =data_ov66_225B5D4
	bl strlen
	mov r2, r0
	ldr r1, _022581EC // =data_ov66_225B5D4
	mov r0, r5
	bl strncmp
	cmp r0, #0
	bne _02258130
	mov r0, r5
	bl DWCi_GsFree
	bl libdwcenc_22584B8
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, pc}
_02258130:
	ldr r0, _022581D8 // =DWCi_ENC_URL_BASE
	ldr r0, [r0, #0x60]
	cmp r0, #0
	beq _02258150
	bl DWCi_GsFree
	ldr r0, _022581D8 // =DWCi_ENC_URL_BASE
	mov r1, #0
	str r1, [r0, #0x60]
_02258150:
	mov r0, r5
	mov r1, r4
	bl DWCi_EncSessionValidateResponse
	cmp r0, #0
	bne _02258178
	mov r0, r5
	bl DWCi_GsFree
	bl libdwcenc_22584B8
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, pc}
_02258178:
	ldr r0, _022581D8 // =DWCi_ENC_URL_BASE
	ldr r2, [r0, #0x70]
	cmp r2, #0
	beq _022581B0
	mov r0, r5
	mov r1, r4
	blx r2
	cmp r0, #0
	bne _022581B0
	mov r0, r5
	bl DWCi_GsFree
	bl libdwcenc_22584B8
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, pc}
_022581B0:
	ldr r0, _022581D8 // =DWCi_ENC_URL_BASE
	mov r1, #8
	str r5, [r0, #0x60]
	str r4, [r0, #0x64]
	str r1, [r0]
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, pc}
_022581CC:
	bl libdwcenc_22584B8
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_022581D8: .word DWCi_ENC_URL_BASE
_022581DC: .word rodata_ov66_2258CF5
_022581E0: .word g_session+0x2c
_022581E4: .word data_ov66_225B5CC
_022581E8: .word g_session+0x70
_022581EC: .word data_ov66_225B5D4
	arm_func_end DWCi_EncSessionCompleteCallback

	arm_func_start DWCi_EncSessionEncrypt
DWCi_EncSessionEncrypt: // 0x022581F0
	stmfd sp!, {r4, r5, r6, r7, r8, sb, sl, lr}
	ldr r4, [sp, #0x20]
	mov sb, r2
	add r7, r4, sb
	mov r4, r0
	mov sl, r1
	add r1, r7, #4
	mov r0, #7
	mov r8, r3
	mov r6, #0
	bl DWC_Alloc
	movs r5, r0
	moveq r0, #2
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, sl, pc}
	cmp sb, #0
	mov r2, r6
	ble _0225824C
_02258234:
	ldrb r1, [sl, r2]
	add r0, r5, r2
	add r2, r2, #1
	strb r1, [r0, #4]
	cmp r2, sb
	blt _02258234
_0225824C:
	ldr r3, [sp, #0x20]
	mov sl, #0
	cmp r3, #0
	ble _02258278
	add r2, r5, sb
_02258260:
	ldrb r1, [r8, sl]
	add r0, r2, sl
	add sl, sl, #1
	strb r1, [r0, #4]
	cmp sl, r3
	blt _02258260
_02258278:
	cmp r7, #0
	mov r1, #0
	ble _0225829C
_02258284:
	add r0, r5, r1
	ldrb r0, [r0, #4]
	add r1, r1, #1
	cmp r1, r7
	add r6, r6, r0
	blt _02258284
_0225829C:
	mov r0, r6
	bl my_randinit
	cmp r7, #0
	mov r8, #0
	ble _022582D0
_022582B0:
	bl my_rand
	add r2, r5, r8
	ldrb r1, [r2, #4]
	add r8, r8, #1
	cmp r8, r7
	eor r0, r1, r0
	strb r0, [r2, #4]
	blt _022582B0
_022582D0:
	ldr r1, _02258334 // =DWCi_ENC_URL_BASE
	mov r0, r5
	ldr r2, [r1, #0x50]
	mov r1, r4
	eor r6, r6, r2
	mov r2, r6, lsr #0x18
	strb r2, [r5]
	mov r2, r6, lsr #0x10
	strb r2, [r5, #1]
	mov r2, r6, lsr #8
	strb r2, [r5, #2]
	add r2, r7, #4
	mov r3, #2
	strb r6, [r5, #3]
	bl B64Encode
	mov r1, r5
	mov r0, #7
	mov r2, #0
	bl DWC_Free
	add r0, r7, #4
	bl b64size
	mov r1, #0
	strb r1, [r4, r0]
	mov r0, r1
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, pc}
	.align 2, 0
_02258334: .word DWCi_ENC_URL_BASE
	arm_func_end DWCi_EncSessionEncrypt

	arm_func_start DWCi_EncSessionInitialize
DWCi_EncSessionInitialize: // 0x02258338
	stmfd sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x28
	mov r5, #0
	add r4, sp, #8
	ldr r2, _022584A4 // =DWCi_ENC_URL_BASE
	sub r3, r5, #1
	strb r5, [r4]
	strb r5, [r4, #1]
	strb r5, [r4, #2]
	strb r5, [r4, #3]
	strb r5, [r4, #4]
	strb r5, [r4, #5]
	strb r5, [r4, #6]
	strb r5, [r4, #7]
	strb r5, [r4, #8]
	str r3, [r2, #8]
	str r5, [r2, #0x54]
	str r5, [r2, #0x58]
	str r5, [r2, #0x5c]
	str r5, [r2, #0x60]
	mov r4, r1
	str r5, [r2, #0x64]
	cmp r0, #0
	beq _022583B4
	cmp r0, #1
	beq _022583C4
	cmp r0, #2
	ldreq r1, _022584A8 // =data_ov66_225B628
	ldreq r0, _022584AC // =data_ov66_225B528
	streq r1, [r0]
	b _022583D0
_022583B4:
	ldr r1, _022584B0 // =data_ov66_225B5DC
	ldr r0, _022584AC // =data_ov66_225B528
	str r1, [r0]
	b _022583D0
_022583C4:
	ldr r1, _022584B4 // =data_ov66_225B604
	ldr r0, _022584AC // =data_ov66_225B528
	str r1, [r0]
_022583D0:
	add r0, sp, #0x11
	mov r1, r4
	mov r2, #0x14
	bl strncpy
	mov r3, #0
	add r0, sp, #8
	add r1, r4, #0x14
	mov r2, #8
	strb r3, [sp, #0x25]
	bl strncpy
	mov r1, #0
	mov r2, #0x10
	bl strtoul
	mov r7, r0
	add r0, sp, #8
	add r1, r4, #0x1c
	mov r2, #8
	bl strncpy
	mov r1, #0
	mov r2, #0x10
	bl strtoul
	mov r6, r0
	add r0, sp, #8
	add r1, r4, #0x24
	mov r2, #8
	bl strncpy
	mov r1, #0
	mov r2, #0x10
	bl strtoul
	mov r5, r0
	add r0, sp, #8
	add r1, r4, #0x2c
	mov r2, #8
	bl strncpy
	mov r1, #0
	mov r2, #0x10
	bl strtoul
	str r5, [sp]
	str r0, [sp, #4]
	mov r2, r7
	mov r3, r6
	add r0, r4, #0x34
	add r1, sp, #0x11
	bl DWCi_EncValidateKey
	mov r0, #0
	bl DWC_InitGHTTP
	ldr r0, _022584A4 // =DWCi_ENC_URL_BASE
	mov r2, #3
	mov r1, #1
	str r2, [r0]
	str r1, [r0, #4]
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_022584A4: .word DWCi_ENC_URL_BASE
_022584A8: .word data_ov66_225B628
_022584AC: .word data_ov66_225B528
_022584B0: .word data_ov66_225B5DC
_022584B4: .word data_ov66_225B604
	arm_func_end DWCi_EncSessionInitialize

	arm_func_start libdwcenc_22584B8
libdwcenc_22584B8: // 0x022584B8
	stmfd sp!, {r3, lr}
	bl DWCi_IsError
	cmp r0, #0
	bne _022584D4
	ldr r1, _022584E4 // =0xFFFEA048
	mov r0, #6
	bl DWCi_SetError
_022584D4:
	ldr r0, _022584E8 // =DWCi_ENC_URL_BASE
	mov r1, #1
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_022584E4: .word 0xFFFEA048
_022584E8: .word DWCi_ENC_URL_BASE
	arm_func_end libdwcenc_22584B8

	arm_func_start DWCi_EncSessionProcess
DWCi_EncSessionProcess: // 0x022584EC
	stmfd sp!, {r3, lr}
	sub sp, sp, #8
	ldr r0, _022585E8 // =DWCi_ENC_URL_BASE
	ldr r1, [r0]
	cmp r1, #8
	addls pc, pc, r1, lsl #2
	b _022585D8
_02258508: // jump table
	b _022585D8 // case 0
	b _0225852C // case 1
	b _022585D8 // case 2
	b _022585D8 // case 3
	b _02258534 // case 4
	b _02258574 // case 5
	b _02258588 // case 6
	b _022585C8 // case 7
	b _022585D8 // case 8
_0225852C:
	bl libdwcenc_22584B8
	b _022585D8
_02258534:
	ldr r2, _022585EC // =DWCi_EncSessionCompleteCallback
	mov r1, #0
	str r2, [sp]
	str r1, [sp, #4]
	ldr r0, [r0, #0x54]
	ldr r3, _022585F0 // =DWCi_EncSessionProgressCallback
	mov r2, r1
	bl DWC_GetGHTTPDataEx
	ldr r1, _022585E8 // =DWCi_ENC_URL_BASE
	cmp r0, #0
	str r0, [r1, #8]
	movge r0, #5
	strge r0, [r1]
	bge _022585D8
	bl libdwcenc_22584B8
	b _022585D8
_02258574:
	bl DWC_ProcessGHTTP
	cmp r0, #0
	bne _022585D8
	bl libdwcenc_22584B8
	b _022585D8
_02258588:
	ldr r2, _022585EC // =DWCi_EncSessionCompleteCallback
	mov r1, #0
	str r2, [sp]
	str r1, [sp, #4]
	ldr r0, [r0, #0x54]
	ldr r3, _022585F0 // =DWCi_EncSessionProgressCallback
	mov r2, r1
	bl DWC_GetGHTTPDataEx
	ldr r1, _022585E8 // =DWCi_ENC_URL_BASE
	cmp r0, #0
	str r0, [r1, #8]
	movge r0, #7
	strge r0, [r1]
	bge _022585D8
	bl libdwcenc_22584B8
	b _022585D8
_022585C8:
	bl DWC_ProcessGHTTP
	cmp r0, #0
	bne _022585D8
	bl libdwcenc_22584B8
_022585D8:
	ldr r0, _022585E8 // =DWCi_ENC_URL_BASE
	ldr r0, [r0]
	add sp, sp, #8
	ldmia sp!, {r3, pc}
	.align 2, 0
_022585E8: .word DWCi_ENC_URL_BASE
_022585EC: .word DWCi_EncSessionCompleteCallback
_022585F0: .word DWCi_EncSessionProgressCallback
	arm_func_end DWCi_EncSessionProcess

	arm_func_start DWCi_EncSessionShutdown
DWCi_EncSessionShutdown: // 0x022585F4
	stmfd sp!, {r3, lr}
	ldr r0, _02258660 // =DWCi_ENC_URL_BASE
	ldr r1, [r0, #0x54]
	cmp r1, #0
	beq _02258620
	mov r0, #7
	mov r2, #0
	bl DWC_Free
	ldr r0, _02258660 // =DWCi_ENC_URL_BASE
	mov r1, #0
	str r1, [r0, #0x54]
_02258620:
	ldr r0, _02258660 // =DWCi_ENC_URL_BASE
	ldr r0, [r0, #0x60]
	cmp r0, #0
	beq _02258644
	bl DWCi_GsFree
	ldr r0, _02258660 // =DWCi_ENC_URL_BASE
	mov r1, #0
	str r1, [r0, #0x64]
	str r1, [r0, #0x60]
_02258644:
	bl DWC_ShutdownGHTTP
	ldr r0, _02258660 // =DWCi_ENC_URL_BASE
	mov r1, #2
	str r1, [r0]
	mov r1, #0
	str r1, [r0, #4]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02258660: .word DWCi_ENC_URL_BASE
	arm_func_end DWCi_EncSessionShutdown

	arm_func_start DWCi_EncSessionGetResponse
DWCi_EncSessionGetResponse: // 0x02258664
	ldr r1, _02258678 // =DWCi_ENC_URL_BASE
	ldr r2, [r1, #0x6c]
	str r2, [r0]
	ldr r0, [r1, #0x68]
	bx lr
	.align 2, 0
_02258678: .word DWCi_ENC_URL_BASE
	arm_func_end DWCi_EncSessionGetResponse

	arm_func_start DWCi_EncSessionGetPrivateAsync
DWCi_EncSessionGetPrivateAsync: // 0x0225867C
	stmfd sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x34
	ldr r4, _022588A4 // =DWCi_ENC_URL_BASE
	mov sl, r0
	ldr r0, [r4, #0xc]
	mov sb, r1
	cmp r0, #1
	str r2, [sp, #0x10]
	mov r8, r3
	addne sp, sp, #0x34
	movne r0, #3
	ldmneia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	ldr r1, [r4, #0x54]
	cmp r1, #0
	beq _022586D0
	mov r0, #7
	mov r2, #0
	bl DWC_Free
	mov r0, r4
	mov r1, #0
	str r1, [r0, #0x54]
_022586D0:
	add r0, r8, #0xc
	bl b64size
	mov r7, r0
	ldr r0, _022588A8 // =data_ov66_225B650
	bl strlen
	mov r6, r0
	ldr r0, _022588AC // =data_ov66_225B5CC
	bl strlen
	mov r5, r0
	ldr r2, _022588B0 // =data_ov66_225B658
	add r0, sp, #0x24
	mov r1, #0x10
	mov r3, sb
	bl snprintf
	mov fp, r0
	ldr r0, _022588B4 // =data_ov66_225B65C
	bl strlen
	str r0, [sp, #0x14]
	mov r0, sl
	bl strlen
	str r0, [sp, #0x18]
	ldr r0, _022588B8 // =data_ov66_225B528
	ldr r0, [r0]
	bl strlen
	mov r4, r0
	ldr r0, _022588BC // =g_session+0xc
	bl strlen
	add r1, r4, r0
	ldr r0, [sp, #0x18]
	add r1, r0, r1
	ldr r0, [sp, #0x14]
	add r0, r0, r1
	add r0, fp, r0
	add r0, r5, r0
	add r0, r0, #0x29
	add r0, r6, r0
	add r1, r7, r0
	mov r0, #7
	bl DWC_Alloc
	ldr r1, _022588A4 // =DWCi_ENC_URL_BASE
	cmp r0, #0
	str r0, [r1, #0x54]
	addeq sp, sp, #0x34
	moveq r0, #2
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	str sl, [sp]
	ldr r1, _022588C0 // =data_ov66_225B680
	str sb, [sp, #4]
	str r1, [sp, #8]
	ldr r2, _022588C4 // =data_ov66_225B6AC
	ldr r1, _022588B8 // =data_ov66_225B528
	str r2, [sp, #0xc]
	ldr r2, [r1]
	ldr r1, _022588C8 // =data_ov66_225B664
	ldr r3, _022588BC // =g_session+0xc
	bl sprintf
	ldr r0, _022588A4 // =DWCi_ENC_URL_BASE
	ldr r4, [r0, #0x54]
	mov r0, r4
	bl strlen
	add r2, r4, r0
	ldr r1, _022588A4 // =DWCi_ENC_URL_BASE
	ldr r0, _022588A8 // =data_ov66_225B650
	str r2, [r1, #0x5c]
	bl strlen
	ldr r4, _022588A4 // =DWCi_ENC_URL_BASE
	ldr r3, [sp, #0x10]
	ldr r5, [r4, #0x5c]
	add r1, sp, #0x1c
	sub r0, r5, r0
	sub r0, r0, #0x28
	str r0, [r4, #0x58]
	str sb, [sp, #0x1c]
	str r8, [sp, #0x20]
	str r8, [sp]
	ldr r0, [r4, #0x5c]
	mov r2, #8
	bl DWCi_EncSessionEncrypt
	cmp r0, #2
	bne _0225883C
	mov r1, r4
	ldr r1, [r1, #0x54]
	mov r0, #7
	mov r2, #0
	bl DWC_Free
	mov r0, r4
	mov r1, #0
	str r1, [r0, #0x54]
	add sp, sp, #0x34
	mov r0, #2
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
_0225883C:
	ldr r0, [sp, #0x5c]
	cmp r0, #0
	beq _0225886C
	mov r0, r4
	ldr r1, _022588CC // =g_session+0x70
	ldr r0, [r0, #0x58]
	mov r2, #0x28
	bl memcpy
	mov r0, r4
	mov r1, #6
	str r1, [r0]
	b _0225888C
_0225886C:
	ldr r0, _022588AC // =data_ov66_225B5CC
	bl strlen
	mov r1, r4
	ldr r3, [r1, #0x58]
	mov r4, #0
	mov r2, #4
	strb r4, [r3, -r0]
	str r2, [r1]
_0225888C:
	ldr r2, [sp, #0x58]
	ldr r1, _022588A4 // =DWCi_ENC_URL_BASE
	mov r0, #0
	str r2, [r1, #0x70]
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_022588A4: .word DWCi_ENC_URL_BASE
_022588A8: .word data_ov66_225B650
_022588AC: .word data_ov66_225B5CC
_022588B0: .word data_ov66_225B658
_022588B4: .word data_ov66_225B65C
_022588B8: .word data_ov66_225B528
_022588BC: .word g_session+0xc
_022588C0: .word data_ov66_225B680
_022588C4: .word data_ov66_225B6AC
_022588C8: .word data_ov66_225B664
_022588CC: .word g_session+0x70
	arm_func_end DWCi_EncSessionGetPrivateAsync

	arm_func_start DWCi_EncSessionGetAsync
DWCi_EncSessionGetAsync: // 0x022588D0
	stmfd sp!, {r3, lr}
	sub sp, sp, #8
	ldr lr, [sp, #0x10]
	mov ip, #0
	str lr, [sp]
	str ip, [sp, #4]
	bl DWCi_EncSessionGetPrivateAsync
	add sp, sp, #8
	ldmia sp!, {r3, pc}
	arm_func_end DWCi_EncSessionGetAsync

	arm_func_start DWCi_EncSessionGetReuseHashAsync
DWCi_EncSessionGetReuseHashAsync: // 0x022588F4
	stmfd sp!, {r3, lr}
	sub sp, sp, #8
	ldr lr, [sp, #0x10]
	mov ip, #1
	str lr, [sp]
	str ip, [sp, #4]
	bl DWCi_EncSessionGetPrivateAsync
	add sp, sp, #8
	ldmia sp!, {r3, pc}
	arm_func_end DWCi_EncSessionGetReuseHashAsync
	// 0x02258918

	.rodata
	.balign 4, 0
rodata_ov66_2258CE4:
	.asciz "0123456789abcdef"

rodata_ov66_2258CF5:
	.asciz "0123456789abcdef"

	.data

	.balign 4, 0
data_ov66_225B528:
	.word 0

	.balign 4, 0
DWCi_ENC_URL_BASE:
	.word 2

	.balign 4, 0
g_session:
	.rept 39
	.word 0
	.endr

	.balign 4, 0
data_ov66_225B5CC:
	.asciz "&hash="

	.balign 4, 0
data_ov66_225B5D4:
	.asciz "error:"

	.balign 4, 0
data_ov66_225B5DC:
	.asciz "http://gamestats2.gs.nintendowifi.net/"

	.balign 4, 0
data_ov66_225B604:
	.asciz "http://sdkdev.gamespy.com/games/"

	.balign 4, 0
data_ov66_225B628:
	.asciz "http://ishikawa.servebeer.com/games/"

	.balign 4, 0
data_ov66_225B650:
	.asciz "&data="

	.balign 4, 0
data_ov66_225B658:
	.asciz "%d"

	.balign 4, 0
data_ov66_225B65C:
	.asciz "?pid="

	.balign 4, 0
data_ov66_225B664:
	.asciz "%s%s%s?pid=%d&hash=%s&data="

	.balign 4, 0
data_ov66_225B680:
	.asciz "0000000000000000000000000000000000000000"

	.balign 4, 0
data_ov66_225B6AC:
	.byte 0

	.bss
s_local_seed:
	.space 4

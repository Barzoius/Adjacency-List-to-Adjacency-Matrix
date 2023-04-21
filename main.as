.data
	Nrcerinta: .space 4
	n: .space 4
	v: .space 400
	i: .space 4
	m: .space 400
	Leg: .space 4
	columnIndex: .space 4
	lineIndex: .space 4
	formatScanf: .asciz "%ld"
	formatPrintf: .asciz "%ld "
	newLine: .asciz "\n"
.text
.global main
main:
	pusha
	pushl $Nrcerinta
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	popa
	
	
	pusha
	pushl $n
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	popa

	xor %ecx, %ecx
	lea v, %esi

forcitire:

	cmp %ecx, n
	je corectare

	pusha
	pushl $i
	pushl $formatScanf
	call scanf
	popl %edx
	popl %edx
	popa
	movl i, %eax
	mov %eax, (%esi, %ecx, 4)

	inc %ecx
	jmp forcitire

corectare:

	xor %ecx, %ecx

et_constructie:
	
	cmp %ecx, n
	je et_afis_matr
	mov (%esi, %ecx, 4), %ebx
	
	et_leg:
	cmp $0, %ebx
	je et_inc
	pusha
	pushl $Leg
	pushl $formatScanf
	call scanf
	popl %edx
	popl %edx
	popa
	
	movl $0, %edx
	movl %ecx, %eax
	mull n
	
	addl Leg, %eax
	
	lea m, %edi
	movl $1 , (%edi, %eax, 4)
	
	dec %ebx
	
	jmp  et_leg
	
	et_inc:
	incl %ecx
	jmp et_constructie
	

et_afis_matr:
	movl $0, lineIndex
	for_lines:
	movl lineIndex, %ecx
	cmp %ecx, n
	je et_exit
	movl $0, columnIndex
		for_columns:
			movl columnIndex, %ecx
			cmp %ecx, n
			je cont

		movl lineIndex, %eax
		movl $0, %edx
		mull n
		addl columnIndex, %eax

	lea m, %edi
	movl (%edi, %eax, 4), %ebx
	pusha
	pushl %ebx
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	popa
	
	pusha
	pushl $0
	call fflush
	popl %ebx
	popa
	
	incl columnIndex
		jmp for_columns
		
	cont:
	   	movl $4, %eax
		movl $1, %ebx
		movl $newLine, %ecx
		movl $1, %edx
		int $0x80
		incl lineIndex
	jmp for_lines
		
		
		et_exit:
		   movl $1, %eax
	           movl $0, %ebx
	           int $0x80

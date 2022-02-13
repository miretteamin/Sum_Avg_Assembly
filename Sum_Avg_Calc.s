.section .data
input: .asciz "%d"    # string terminated by 0 that will be used for scanf parameter
inputNb: .asciz "%lf"
output: .asciz "sum=%f "     # string terminated by 0 that will be used for printf parameter
outputA: .asciz "avg=%f\n"

n: .int 0
s: .double 0.0

avg: .double 0.0
acc: .double 0.0
r: .double 0.0
.section .text
.globl _main

_main:
   pushl $n
   pushl $input
   call _scanf

   add $8, %esp
   movl $0, %ecx

loop1:
    pushl %ecx
    pushl $acc+4
    pushl $acc
    pushl $inputNb
    call _scanf
    add $12, %esp


    popl %ecx
    fldl s

    faddl acc
    fstpl s


    add $1, %ecx 
    cmpl %ecx,n
    ja loop1

    pushl s+4
    pushl s
    pushl $output
    call _printf
    add $12, %esp

    cvtpi2pd n, %xmm0   #convert n from int to double
    movdqu %xmm0, r

    fldl s
    fdivl r
    fstpl avg

    pushl avg+4
    pushl avg
    pushl $outputA
    call _printf
    add $12, %esp

    ret
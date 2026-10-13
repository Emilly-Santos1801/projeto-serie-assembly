#50. Entrar com o número de termos da série (n), que deve ser maior que zero, caso não seja, deve ser novamente solicitado, 
#e imprimir o valor de H, sendo: H = (1*4)(+2)(+3*4)(+4)(+5*4)(+6)+... 
				#      1   2    3    4    5    6     termos
#Observação: cada multiplicação é um termo. Entender a série é fundamental para a resolução do problema.

.data 
n : .asciiz " - Digite o valor: "
n1 : .asciiz "Por favor, maior que zero, tente de novo."
H: .asciiz "O valor de H, é: "

.text
#declarando n 
loopcerto: 
	li $v0, 4
	la $a0, n
	syscall
	li $v0, 5
	syscall
	move $s0, $v0
	bltz $s0, looperro
	beq $s0, 0, looperro
	j comeco  #dps q num digitado e maior que zero vai para comeco
	
	

looperro:
	#declarando n1
	li $v0, 4
	la $a0, n1 #se o num é menor q zero, mostra uma mensagem solicitando ele
	syscall
	j loopcerto #chamando o loop
	
comeco: #Aqui é pro sistema entender que
	li $t3, 2 #$t3 vai começar com 2
	li $t0, 1 #$t0 vai começar com 1
	li $t4, 0 #contador para comparação
	LI $t6, 0 #cont
	#após isso, chama looptermo
looptermo:
#para saber qual é impar e qual é par (cada multiplicação é um termo)
	li $t7, 2
	div $t4, $t7 #zero dividido por 2 
	mfhi $t1 #se o resto for 0
	beq $t1, 1, par #vai pra par
	
impar:
	mul $t2, $t0, 4 #multiplicação dos impares
	add $t0, $t0, 2
	j soma
	
par: 
	move $t2, $t3
	add $t3, $t3, 2 #soma dos pares
	
soma: 
	add $t6, $t6, $t2 # ACUMULADOR: Soma Total = Soma Total + Termo Atual (1x4+2...
	add $t4, $t4, 1   # contador
	
	beq $t4, $s0, mostraagapar # Se o contador chegou no numero do usuario, fim do loop
	j looptermo
	
		
mostraagapar: 
	li $v0, 4
	la $a0, H
	syscall
	li $v0, 1
	move $a0, $t6 
	syscall
	
	
fim:
	li $v0, 10
	syscall
	
	
	




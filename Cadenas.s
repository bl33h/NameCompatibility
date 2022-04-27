/* -----------------------------------------------
* UNIVERSIDAD DEL VALLE DE GUATEMALA
* Sara Maria Perez Echeverria 21371
* Fabian Estuardo Juarez Tello 21440
* Organización de computadoras y Assembler
* Ciclo 1 - 2022
*
* Programa que determina la compatibilidad del
* primer nombre con el primer apellido y la buena
* fortuna del individuo en base a un sistema de
* puntaje basado en 3 diferentes criterios.
 ----------------------------------------------- */
    @@ codigo de assembler: se coloca en la seccion .text
.text
.align 2
    @@ etiqueta "main" llama a la funcion global
.global main
.type main, %function
main:
    @@ grabar registro de enlace en la pila
stmfd sp!, {lr}
/*impresion de menu y pide comando*/
Menu:
    ldr r0,=menu
    bl puts
    ldr r0,=opcion
    ldr r1,=comando
    bl scanf

/*compara comandos*/
comp:
/*saltos dependiendo de caracter*/
    ldr r4,=comando
    ldrb r4,[r4]
    cmp r4, #'s'
    beq ejecucion
    cmpne r4, #'q'
    beq Salir
    bne ErrorCar

 /* ejecucion */
    ejecucion:
    @Nombre
    ldr r0,=ingresoN
    bl puts
    ldr r0,=entrada
    ldr r1,=n
    bl scanf

    @Apellido
    ldr r0,=ingresoA
    bl puts
    ldr r0,=entrada
    ldr r1,=a
    bl scanf

    @Contencion de informacion
    ldr r8,=n
	ldr r9,=a

    @Contador n
    mov r10,#0

    @Contador a
    mov r11,#0

    @Parte1
    name:
    ldr r1,[r8]	@valor para contar caracteres
    add r8, #1
	add r10,#1
    lastName:
    ldr r2,[r9]	@valor para contar caracteres
	ldr r0,=formatoC
	add r9, #1
	add r11,#1

    cmp r1, #0x00H @Error: garbage following instruction -- `cmp r1,#0x00H'
    bne name
    cmp r2, #0x00H
    bne lastName
    cmp r10,r11
    beq suma

    @Parte2

    @Parte3
    
    b Salir

suma:
ldr r5,=f
add r5,#1

/* salto para error de comando*/
ErrorCar:
ldr r0,=error
bl puts
bl getchar
b Menu

/* si pone q sale*/
Salir:
ldr r0,=adios
bl puts
ldr r1,=f
bl printf
mov r0, #0
mov r3, #0
ldmfd sp!, {lr}
bx lr
.data
.align 2

n: .asciz "  "
a: .asciz "  "
f: .word 0
formatoN:	.asciz "%d "

menu:
    .asciz "------- Bienvenido a MiPrimerBebe.com -------\n A continuacion ingrese el posible nombre y apellido de su bebe y evaluaremos la fortuna que este tendria considerando los siguientes criterios:\n- Ambos nombre y apellido tienen la misma cantidad de letras\n- Ambos nombre y apellido tienen el mismo número de vocales\n- Ambos nombre y apellido terminan con la exacta misma letra\nEl nombre sera aprobado si su puntuacion es mayor que 2.\n\n--- COMANDOS ---\n(s) Ejecutar el programa\n(q) Salir"
opcion:
    .asciz " %c"
comando:
    .byte 0
entrada:
    .asciz " %s"
ingresoN:
    .asciz "Ingrese su nombre: "
ingresoA:
    .asciz "Ingrese su apellido: "
error:
    .asciz "Ingreso incorrecto"
adios:
    .asciz "Hasta pronto"

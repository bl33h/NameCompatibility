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

/*------------------------------------ Main ------------------------------------*/
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
mov r10,#2
Menu:
    ldr r0,=menu
    bl puts
    ldr r0,=opcion
    ldr r1,=comando
    bl scanf

/*------------------------------------ Comandos ------------------------------------*/
/*Reconocimiento de comandos en el menu*/
comp:
/*saltos dependiendo de caracter*/
    ldr r4,=comando
    ldrb r4,[r4]
    cmp r4, #'s' @@comando de ejecucion
    beq ejecucion
    cmp r4, #'q' @@comando de salida
    beq salir
    bne ErrorCar @@error caracter incorrecto

/*------------------------------------ Inputs ------------------------------------*/
 /* ejecucion */
    ejecucion:
    sub r10,#1
    cmp r10,#-1
    bne verificacion
    beq control
    
verificacion:
cmp r10,#1
    beq nombre
    bne apellido

nombre:
    @Nombre
    ldr r0,=ingresoN
    bl puts
    ldr r0,=entrada
    ldr r1,=n
    ldr r4,=n
    bl scanf

/*------------------------------------ Nombre -----------------------------------*/
name:
    @@ se detendra hasta que sea nulo
    ldrb r1,[r4],#1
    cmp r1,#0
    addne r5,#1
    bne name

    ldr r1,=cn
    str r5,[r1]
    mov r5,#0

@Parte3
ldr r4,=nombre
ldr r5,=cn

 ldr r5,[r5]
 sub r5,#1
 ldr r9,[r5,r4]
 ldr r1,=un
 str r9,[r1]
 add r5,#1



p2n:
 @Parte2
ldrb r1,[r4],#1	@letra para corroborar si hay vocal

    case_A:
    cmp r1,#'A'
    addeq r7,#1

    case_E:
    cmp r1,#'E'
    addeq r7,#1

    Case_I:
    cmp r1,#'I'
    addeq r7,#1

    case_O:
    cmp r1,#'O'
    addeq r7,#1

    case_U:
    cmp r1,#'U'
    addeq r7,#1

    case_a:
    cmp r1,#'a'
    addeq r7,#1

    case_e:
    cmp r1,#'e'
    addeq r7,#1

    case_i:
    cmp r1,#'i'
    addeq r7,#1

    case_o:
    cmp r1,#'o'
    addeq r7,#1

    case_u:
    cmp r1,#'u'
    addeq r7,#1
    
    subs r5,#1 
    bne p2n
    ldr r1,=vn
    str r7,[r1]
    mov r7,#0
    b ejecucion
	
apellido:
    @Apellido
    ldr r0,=ingresoA
    bl puts
    ldr r0,=entrada
    ldr r1,=a
    ldr r4,=a
    bl scanf

@Contencion de informacion
    ldr r4,=a
/*------------------------------------ Apellido ------------------------------------*/

lastname:
    @@ se detendra hasta que sea nulo
    ldrb r1,[r4],#1
    cmp r1,#0
    addne r5,#1
    bne lastname

    ldr r1,=ca
    str r5,[r1]
    mov r5,#0

    b ejecucion

control:
@primera parte
ldr r1,=cn
ldr r1,[r1]
ldr r2,=ca
ldr r2,[r2]
cmp r1,r2
addeq r8,#1

@segunda parte
ldr r1,=vn
ldr r1,[r1]
ldr r2,=va
ldr r2,[r2]
cmp r1,r2
addeq r8,#1

@tercera parte
ldr r1,=un
ldr r1,[r1]
ldr r2,=ua
ldr r2,[r2]
cmp r1,r2
addeq r8,#1

@@ Guardar resultado obtenido
    ldr r1,=f
    str r8,[r1]

    @@ Imprimir punteo 
    ldr r1,=f
    ldr r1,[r1]
    cmp r1,#2
    ldrpl r0,=aprobado
    ldrmi r0,=reprobado
    bl printf

b salir

/*------------------------------------ Control de errores ------------------------------------*/
/* salto para error de comando*/
ErrorCar:
ldr r0,=error
bl puts
bl getchar
b Menu

/*--- Comando de salida del menu ---*/
/* si pone q sale*/
salir:
ldr r0,=adios
bl puts
mov r0, #0
mov r3, #0
ldmfd sp!, {lr}
bx lr
.data
.align 2

/*------------------------------------ Variables y formato ------------------------------------*/
n: .asciz "  " @@nombre
a: .asciz "  " @@apellido
f: .word 0
cn: .word 0 @@cantidad caracteres nombre
vn: .word 0 @@cantidad vocales nombre
un: .word 0 @@ultimo caracter del nombre
ca: .word 0
va: .word 0
ua: .word 0
formatoN:	.asciz "%d "
empty:            .asciz  " "
texto:            .asciz    "%c"

/*------------------------------------ Instrucciones ------------------------------------*/
menu:
    .asciz "------- Bienvenido a MiPrimerBebe.com -------\n A continuacion ingrese el posible nombre y apellido de su bebe y evaluaremos la fortuna que este tendria considerando los siguientes criterios:\n- Ambos nombre y apellido tienen la misma cantidad de letras\n- Ambos nombre y apellido tienen el mismo número de vocales\n- Ambos nombre y apellido terminan con la exacta misma letra\nEl nombre sera aprobado si su puntuacion es mayor que 2.\n\n--- COMANDOS ---\n(s) Ejecutar el programa\n(q) Salir" @@bienvenida
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
aprobado:
    .asciz "\nEl nombre esta aprobado\n"
reprobado:
    .asciz "\nEl nombre esta reprobado"
error:
    .asciz "Ingreso incorrecto"
adios:
    .asciz "Hasta pronto"

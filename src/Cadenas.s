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

/*--- Inicio ---*/
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

/*--- Reconocimiento de comandos en el menu ---*/
/*compara comandos*/
comp:
/*saltos dependiendo de caracter*/
    ldr r4,=comando
    ldrb r4,[r4]
    cmp r4, #'s'
    beq ejecucion
    cmp r4, #'q'
    beq Salir
    bne ErrorCar

/*--- Inputs ---*/
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
    cmp r1, #32
    bne name

    lastName:
    ldr r2,[r9]	@valor para contar caracteres
	add r9, #1
	add r11,#1
    cmp r2, #32
    bne lastName

    cmp r10,r11
    beq suma

    ldr r0,=formatoN
    ldr r1,=f
    ldr r1,[r1]
    bl printf

    @Parte2
    @Contencion de informacion
    ldr r8,=n
	ldr r9,=a
    @Contador n
    mov r10,#0

    @Contador a
    mov r11,#0

    nameP2:
    ldr r1,[r8]	@letra para corroborar si hay vocal
    add r8, #1

    case_A:
    cmp r1,#'A'
    addeq r10,#1

    case_E:
    cmp r1,#'E'
    addeq r10,#1

    Case_I:
    cmp r1,#'I'
    addeq r10,#1

    case_O:
    cmp r1,#'O'
    addeq r10,#1

    case_U:
    cmp r1,#'U'
    addeq r10,#1

    case_a:
    cmp r1,#'a'
    addeq r10,#1

    case_e:
    cmp r1,#'e'
    addeq r10,#1

    case_i:
    cmp r1,#'i'
    addeq r10,#1

    case_o:
    cmp r1,#'o'
    addeq r10,#1

    case_u:
    cmp r1,#'u'
    addeq r10,#1
    cmp r1,#32
    bne nameP2

    lastNameP2:
    ldr r2,[r9]	@valor para contar caracteres
	add r9, #1


	case_A2:
    cmp r2,#'A'
    addeq r11,#1

    case_E2:
    cmp r2,#'E'
    addeq r11,#1

    Case_I2:
    cmp r2,#'I'
    addeq r11,#1

    case_O2:
    cmp r2,#'O'
    addeq r11,#1

    case_U2:
    cmp r2,#'U'
    addeq r11,#1

    case_a2:
    cmp r2,#'a'
    addeq r11,#1

    case_e2:
    cmp r2,#'e'
    addeq r11,#1

    case_i2:
    cmp r2,#'i'
    addeq r11,#1

    case_o2:
    cmp r2,#'o'
    addeq r11,#1

    case_u2:
    cmp r2,#'u'
    addeq r11,#1
    cmp r2, #32
    bne lastNameP2

    cmp r10,r11
    beq suma
    @Parte3
    
    b Salir

suma:
ldr r5,=f
ldr r5,[r5]
add r5,#1
str r5,[r5]


/*--- Control de errores ---*/
/* salto para error de comando*/
ErrorCar:
ldr r0,=error
bl puts
bl getchar
b Menu

/*--- Comando de salida del menu ---*/
/* si pone q sale*/
Salir:
ldr r0,=adios
bl puts
ldr r2,=f
ldr r1,[r2]
bl printf
mov r0, #0
mov r3, #0
ldmfd sp!, {lr}
bx lr
.data
.align 2


/*--- Variables y formato ---*/
n: .asciz "  "
a: .asciz "  "
f: .word 0
formatoN:	.asciz "%d "


/*--- Instrucciones ---*/
menu:
    .asciz .asciz "------- Bienvenido a MiPrimerBebe.com -------\n A continuacion 
    ingrese el posible nombre y apellido de su bebe y evaluaremos la fortuna que este
    tendria considerando los siguientes criterios:\n- Ambos nombre y apellido tienen 
    la misma cantidad de letras\n- Ambos nombre y apellido tienen el mismo número de 
    vocales\n- Ambos nombre y apellido terminan con la exacta misma letra\nEl nombre 
    sera aprobado si su puntuacion es mayor que 2.\n\n--- COMANDOS ---\n(s) Ejecutar 
    el programa\n(q) Salir"
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

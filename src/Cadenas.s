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
/*--- Reconocimiento de comandos en el menu ---*/
/*compara comandos*/
comp:
/*saltos dependiendo de caracter*/
    ldr r4,=comando
    ldrb r4,[r4]
    cmp r4, #'s'
    beq ejecucion
    cmp r4, #'q'
    beq salir
    bne ErrorCar

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

apellido:
@Apellido
    ldr r0,=ingresoA
    bl puts
    ldr r0,=entrada
    ldr r1,=a
    ldr r4,=a
    bl scanf

control:
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

/*--- Variables y formato ---*/
n: .asciz "  "
a: .asciz "  "
f: .word 1
cn: .word 0
ca: .word 0
formatoN:	.asciz "%d "
empty:            .asciz  ""
texto:            .asciz    "%c"

/*------------------------------------ Instrucciones ------------------------------------*/
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

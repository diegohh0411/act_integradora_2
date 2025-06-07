# Este archivo contiene ejemplos de todas las clases léxicas de Python
"""
Comentario de múltiples líneas
que demuestra las docstrings
"""

# Importaciones con diferentes variantes
import math
import os as sistema
from collections import defaultdict, Counter
from typing import List, Dict, Optional, Union

# Keywords: def, class, if, elif, else, for, while, try, except, finally, with, as, import, from, return, yield, break, continue, pass, global, nonlocal, lambda, and, or, not, in, is, True, False, None

# Definición de clase con herencia
class MiClase(object):
    """Docstring de la clase"""
    
    # Variable de clase
    variable_clase = "valor_clase"
    
    def __init__(self, parametro: int = 0):
        # Operador de asignación
        self.atributo = parametro
        self._atributo_privado = None
        self.__atributo_muy_privado = "secreto"
    
    def metodo_ejemplo(self, x: float, y: float) -> float:
        """Método que demuestra operadores aritméticos"""
        # Operadores aritméticos: +, -, *, /, //, %, **
        suma = x + y
        resta = x - y
        multiplicacion = x * y
        division = x / y
        division_entera = x // y
        modulo = x % y
        potencia = x ** y
        
        # Operadores de asignación compuesta: +=, -=, *=, /=, //=, %=, **=
        suma += 10
        resta -= 5
        multiplicacion *= 2
        division /= 3
        
        return suma

# Función con diferentes tipos de parámetros
def funcion_compleja(*args, **kwargs):
    """Función con argumentos variables"""
    # Operadores de comparación: ==, !=, <, >, <=, >=, is, is not, in, not in
    if len(args) > 0 and args[0] is not None:
        print(f"Primer argumento: {args[0]}")
    
    # Operadores lógicos: and, or, not
    if args and kwargs and not (len(args) == 0 or len(kwargs) == 0):
        print("Tenemos argumentos")
    
    # Operadores de membresía: in, not in
    if 'clave' in kwargs:
        print("Clave encontrada")
    
    # Operadores de identidad: is, is not
    if args[0] is True:
        print("Es verdadero")

# Función lambda
lambda_func = lambda x, y: x + y if x > 0 else y

# Diferentes tipos de datos
# Enteros (decimales, hexadecimales, octales, binarios)
entero_decimal = 42
entero_hex = 0xFF
entero_octal = 0o777
entero_binario = 0b1010

# Flotantes
flotante = 3.14159
flotante_cientifico = 1.5e-10
flotante_negativo = -2.718

# Números complejos
complejo = 3 + 4j

# Strings con diferentes tipos de comillas
string_simple = 'cadena simple'
string_doble = "cadena doble"
string_triple = '''cadena
de múltiples
líneas'''
string_raw = r"cadena raw con \n caracteres especiales"
string_formatted = f"String formateado: {entero_decimal}"
string_unicode = "cadena con unicode: ñáéíóú"

# Listas con diferentes elementos
lista = [1, 2, 3, "texto", True, None, [1, 2]]
lista_comprension = [x**2 for x in range(10) if x % 2 == 0]

# Tuplas
tupla = (1, 2, 3)
tupla_un_elemento = (42,)

# Diccionarios
diccionario = {
    "clave1": "valor1",
    "clave2": 42,
    'clave3': [1, 2, 3],
    42: "clave numérica"
}
dict_comprension = {k: v**2 for k, v in enumerate(range(5))}

# Conjuntos
conjunto = {1, 2, 3, 4, 5}
conjunto_vacio = set()

# Operadores bit a bit: &, |, ^, ~, <<, >>
resultado_and = 5 & 3
resultado_or = 5 | 3
resultado_xor = 5 ^ 3
resultado_not = ~5
desplazamiento_izq = 5 << 2
desplazamiento_der = 20 >> 2

# Estructura de control: if-elif-else
def control_flujo(valor):
    if valor > 10:
        print("Mayor que 10")
    elif valor > 5:
        print("Entre 5 y 10")
    else:
        print("Menor o igual a 5")

# Bucles: for y while
def bucles_ejemplo():
    # Bucle for
    for i in range(10):
        if i == 5:
            continue  # Salta a la siguiente iteración
        if i == 8:
            break     # Sale del bucle
        print(i)
    
    # Bucle while
    contador = 0
    while contador < 5:
        print(f"Contador: {contador}")
        contador += 1

# Manejo de excepciones: try-except-finally
def manejo_excepciones():
    try:
        resultado = 10 / 0
    except ZeroDivisionError as e:
        print(f"Error: {e}")
    except Exception as e:
        print(f"Error general: {e}")
    else:
        print("No hubo errores")
    finally:
        print("Siempre se ejecuta")

# Context manager: with
def context_manager_ejemplo():
    with open("archivo.txt", "w") as archivo:
        archivo.write("Contenido del archivo")

# Generadores y yield
def generador():
    for i in range(5):
        yield i**2

# Decoradores
def decorador(func):
    def wrapper(*args, **kwargs):
        print("Antes de la función")
        resultado = func(*args, **kwargs)
        print("Después de la función")
        return resultado
    return wrapper

@decorador
def funcion_decorada():
    print("Función decorada")

# Variables globales y nonlocal
variable_global = "global"

def funcion_externa():
    variable_local = "local"
    
    def funcion_interna():
        nonlocal variable_local
        global variable_global
        variable_local = "modificada"
        variable_global = "modificada globalmente"
    
    funcion_interna()
    return variable_local

# Expresiones regulares y caracteres especiales
patron_regex = r"[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}"

# Función principal
def main():
    """Función principal que demuestra el uso de todas las clases léxicas"""
    print("=== Demostración de clases léxicas ===")
    
    # Instanciar clase
    objeto = MiClase(100)
    resultado = objeto.metodo_ejemplo(10.5, 5.2)
    
    # Llamar funciones
    funcion_compleja(1, 2, 3, clave="valor", otra_clave=42)
    control_flujo(15)
    bucles_ejemplo()
    manejo_excepciones()
    
    # Usar generador
    gen = generador()
    for valor in gen:
        print(f"Valor generado: {valor}")
    
    # Función decorada
    funcion_decorada()
    
    # Función externa
    resultado_local = funcion_externa()
    print(f"Resultado local: {resultado_local}")
    
    # Operador ternario
    resultado_ternario = "positivo" if resultado > 0 else "negativo"
    print(f"Resultado ternario: {resultado_ternario}")
    
    # Función lambda
    resultado_lambda = lambda_func(5, 3)
    print(f"Resultado lambda: {resultado_lambda}")
    
    # Unpacking
    a, b, *resto = [1, 2, 3, 4, 5]
    print(f"a={a}, b={b}, resto={resto}")
    
    # Walrus operator (Python 3.8+)
    if (n := len(lista)) > 5:
        print(f"Lista tiene {n} elementos")
    
    return 0

# Ejecutar si es el archivo principal
if __name__ == "__main__":
    # Comentario de línea final
    exit_code = main()  # Llamada a función principal
    exit(exit_code)     # Salida del programa
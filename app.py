import tkinter as tk
from tkinter import ttk, messagebox
from tkinter import font  # Importar el submódulo font
from conexion import conn

# Función para obtener datos de la base de datos
def obtener_datos(query):
    try:
        cursor = conn.cursor()
        cursor.execute(query)
        resultados = [fila[0] for fila in cursor.fetchall()]
        return resultados
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo obtener datos: {e}")
        return []

# Función para validar campos vacíos
def validar_campos():
    if not entry_nombre.get().strip() or not entry_apellido.get().strip() or not entry_telefono.get().strip() or not entry_correo.get().strip():
        messagebox.showerror("Error", "Todos los campos son obligatorios.")
        return False
    return True

# Función para agregar un empleado
def agregar_empleado():
    if not validar_campos():
        return
    try:
        departamento = combo_departamento.get().strip()
        if not departamento:
            messagebox.showerror("Error", "El campo Departamento es obligatorio.")
            return

        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO empleado (nombre, apellido, telefono, correo, departamento) VALUES (?, ?, ?, ?, ?)",
            (entry_nombre.get().strip(), entry_apellido.get().strip(), entry_telefono.get().strip(), entry_correo.get().strip(), departamento)
        )
        conn.commit()
        messagebox.showinfo("Éxito", "Empleado agregado correctamente.")
        cargar_empleados()
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo agregar el empleado: {e}")

# Función para eliminar un empleado
def eliminar_empleado():
    try:
        selected_item = tree_empleados.selection()
        if not selected_item:
            messagebox.showerror("Error", "Por favor, selecciona un empleado para eliminar.")
            return

        # Obtener el ID del empleado seleccionado y limpiarlo
        empleado_id_str = tree_empleados.item(selected_item[0], "values")[0]
        empleado_id = int(empleado_id_str.strip("()'"))  # Limpia y convierte a entero

        # Ejecutar la eliminación
        cursor = conn.cursor()
        cursor.execute("DELETE FROM empleado WHERE id_emp = ?", (empleado_id,))
        conn.commit()
        messagebox.showinfo("Éxito", "Empleado eliminado correctamente.")
        cargar_empleados()
    except ValueError:
        messagebox.showerror("Error", "El ID del empleado no es válido.")
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo eliminar el empleado: {e}")

# Función para actualizar un empleado
def actualizar_empleado():
    if not validar_campos():
        return
    try:
        selected_item = tree_empleados.selection()
        if not selected_item:
            messagebox.showerror("Error", "Por favor, selecciona un empleado para actualizar.")
            return

        empleado_id = int(tree_empleados.item(selected_item[0], "values")[0])
        departamento = combo_departamento.get().strip()
        if not departamento:
            messagebox.showerror("Error", "El campo Departamento es obligatorio.")
            return

        cursor = conn.cursor()
        cursor.execute(
            "UPDATE empleado SET nombre = ?, apellido = ?, telefono = ?, correo = ?, departamento = ? WHERE id_emp = ?",
            (entry_nombre.get().strip(), entry_apellido.get().strip(), entry_telefono.get().strip(), entry_correo.get().strip(), departamento, empleado_id)
        )
        conn.commit()
        messagebox.showinfo("Éxito", "Empleado actualizado correctamente.")
        cargar_empleados()
    except ValueError:
        messagebox.showerror("Error", "El ID del empleado no es válido.")
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo actualizar el empleado: {e}")

# Función para cargar empleados en la tabla
def cargar_empleados():
    for item in tree_empleados.get_children():
        tree_empleados.delete(item)
    try:
        cursor = conn.cursor()
        cursor.execute("SELECT id_emp, nombre, apellido, telefono, correo, departamento FROM empleado")
        for row in cursor.fetchall():
            # Limpia los valores antes de insertarlos en el Treeview
            clean_row = tuple(str(value).strip("()'") for value in row)
            tree_empleados.insert("", "end", values=clean_row)
        ajustar_ancho_columnas()
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo cargar la lista de empleados: {e}")

# Función para ajustar el ancho de las columnas
def ajustar_ancho_columnas():
    for col in tree_empleados["columns"]:
        tree_empleados.column(col, width=font.Font().measure(col))
        for item in tree_empleados.get_children():
            texto = str(tree_empleados.item(item, "values")[tree_empleados["columns"].index(col)])
            ancho = font.Font().measure(texto)
            if tree_empleados.column(col, option="width") < ancho:
                tree_empleados.column(col, width=ancho)

# Función para rellenar los campos al seleccionar un empleado
def rellenar_campos(event):
    try:
        selected_item = tree_empleados.selection()
        if not selected_item:
            return

        # Obtener los valores del empleado seleccionado
        valores = tree_empleados.item(selected_item[0], "values")
        entry_nombre.delete(0, tk.END)
        entry_nombre.insert(0, valores[1])  # Nombre

        entry_apellido.delete(0, tk.END)
        entry_apellido.insert(0, valores[2])  # Apellido

        entry_telefono.delete(0, tk.END)
        entry_telefono.insert(0, valores[3])  # Teléfono

        entry_correo.delete(0, tk.END)
        entry_correo.insert(0, valores[4])  # Correo

        combo_departamento.set(valores[5])  # Departamento
    except Exception as e:
        messagebox.showerror("Error", f"No se pudieron rellenar los campos: {e}")

# Obtener datos de los departamentos
departamentos = obtener_datos("SELECT NombreDep FROM departamentos")

# Crear la ventana principal
root = tk.Tk()
root.title("Gestión de Empleados")
root.geometry("900x600")
root.configure(bg="#f0f0f0")

# Encabezado
header_frame = tk.Frame(root, bg="#2ecc71", height=80)
header_frame.pack(fill="x")
header_label = tk.Label(header_frame, text="Gestión de Empleados", font=("Arial", 20, "bold"), fg="white", bg="#2ecc71")
header_label.pack(pady=20)

# Contenedor principal
main_frame = tk.Frame(root, bg="#f0f0f0", padx=20, pady=20)
main_frame.pack(fill="both", expand=True)

# Estilos
label_font = ("Arial", 12, "bold")
entry_font = ("Arial", 10)
label_fg = "#333333"
entry_bg = "#ffffff"
entry_fg = "#333333"

# Campos del formulario
tk.Label(main_frame, text="* Nombre:", font=label_font, fg=label_fg, bg="#f0f0f0").grid(row=0, column=0, sticky="e", padx=10, pady=5)
entry_nombre = tk.Entry(main_frame, bg=entry_bg, fg=entry_fg, font=entry_font, relief="solid")
entry_nombre.grid(row=0, column=1, padx=10, pady=5, ipadx=5, ipady=3)

tk.Label(main_frame, text="* Apellido:", font=label_font, fg=label_fg, bg="#f0f0f0").grid(row=0, column=2, sticky="e", padx=10, pady=5)
entry_apellido = tk.Entry(main_frame, bg=entry_bg, fg=entry_fg, font=entry_font, relief="solid")
entry_apellido.grid(row=0, column=3, padx=10, pady=5, ipadx=5, ipady=3)

tk.Label(main_frame, text="* Teléfono:", font=label_font, fg=label_fg, bg="#f0f0f0").grid(row=1, column=0, sticky="e", padx=10, pady=5)
entry_telefono = tk.Entry(main_frame, bg=entry_bg, fg=entry_fg, font=entry_font, relief="solid")
entry_telefono.grid(row=1, column=1, padx=10, pady=5, ipadx=5, ipady=3)

tk.Label(main_frame, text="* Correo:", font=label_font, fg=label_fg, bg="#f0f0f0").grid(row=1, column=2, sticky="e", padx=10, pady=5)
entry_correo = tk.Entry(main_frame, bg=entry_bg, fg=entry_fg, font=entry_font, relief="solid")
entry_correo.grid(row=1, column=3, padx=10, pady=5, ipadx=5, ipady=3)

tk.Label(main_frame, text="Departamento:", font=label_font, fg=label_fg, bg="#f0f0f0").grid(row=2, column=0, sticky="e", padx=10, pady=5)
combo_departamento = ttk.Combobox(main_frame, font=entry_font, state="readonly", values=departamentos)
combo_departamento.grid(row=2, column=1, padx=10, pady=5, ipadx=5, ipady=3)

# Tabla de empleados
tree_empleados = ttk.Treeview(root, columns=("ID", "Nombre", "Apellido", "Telefono", "Correo", "Departamento"), show="headings")
tree_empleados.heading("ID", text="ID")
tree_empleados.heading("Nombre", text="Nombre")
tree_empleados.heading("Apellido", text="Apellido")
tree_empleados.heading("Telefono", text="Teléfono")
tree_empleados.heading("Correo", text="Correo")
tree_empleados.heading("Departamento", text="Departamento")
tree_empleados.pack(fill="both", expand=True, padx=20, pady=10)

# Asociar el evento de selección al Treeview
tree_empleados.bind("<<TreeviewSelect>>", rellenar_campos)

# Función para limpiar los campos
def limpiar_campos():
    """Limpia todos los campos de entrada."""
    entry_nombre.delete(0, tk.END)
    entry_apellido.delete(0, tk.END)
    entry_telefono.delete(0, tk.END)
    entry_correo.delete(0, tk.END)
    combo_departamento.set("")

# Botones de CRUD
btn_frame = tk.Frame(root, bg="#f0f0f0")
btn_frame.pack(fill="x", pady=10)

btn_agregar = tk.Button(btn_frame, text="Agregar", font=("Arial", 12), bg="#2ecc71", fg="white", command=agregar_empleado)
btn_agregar.pack(side="left", padx=10)

btn_actualizar = tk.Button(btn_frame, text="Actualizar", font=("Arial", 12), bg="#3498db", fg="white", command=actualizar_empleado)
btn_actualizar.pack(side="left", padx=10)

btn_eliminar = tk.Button(btn_frame, text="Eliminar", font=("Arial", 12), bg="#e74c3c", fg="white", command=eliminar_empleado)
btn_eliminar.pack(side="left", padx=10)

# Botón para limpiar los campos
btn_limpiar = tk.Button(btn_frame, text="Limpiar", font=("Arial", 12), bg="#f39c12", fg="white", command=limpiar_campos)
btn_limpiar.pack(side="left", padx=10)

# Cargar empleados al iniciar
cargar_empleados()

# Iniciar el bucle principal
root.mainloop()
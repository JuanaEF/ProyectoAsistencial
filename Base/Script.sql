from django.db import models

class Persona(models.Model):
    nombre = models.CharField(max_length=100)
    edad = models.IntegerField()
    genero = models.CharField(max_length=10)
    situacion_socioeconomica = models.CharField(max_length=50)
    direccion = models.CharField(max_length=200)
    telefono = models.CharField(max_length=15)
    email = models.EmailField(max_length=100)
    tipo_documento = models.CharField(max_length=50)
    documento_id = models.CharField(max_length=50, unique=True)
    fecha_nacimiento = models.DateField()
    estado_postulacion = models.CharField(max_length=20)
    fecha_registro = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.nombre
CREATE DATABASE IF NOT EXISTS gestion_postulaciones;

USE gestion_postulaciones;

-- Tabla: Personas (Beneficiarios)
CREATE TABLE Personas (
    id_persona INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    edad INT,
    genero VARCHAR(10),
    situacion_socioeconomica VARCHAR(50),
    direccion VARCHAR(200),
    telefono VARCHAR(15),
    email VARCHAR(100),
    tipo_documento VARCHAR(50),
    documento_id VARCHAR(50) UNIQUE,
    fecha_nacimiento DATE,
    estado_postulacion VARCHAR(20),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: Postulaciones
CREATE TABLE Postulaciones (
    id_postulacion INT AUTO_INCREMENT PRIMARY KEY,
    id_persona INT,
    tipo_beneficio VARCHAR(100),
    fecha_postulacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20),
    documentos_presentados BOOLEAN,
    comentarios TEXT,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_persona) REFERENCES Personas(id_persona)
);

-- Tabla: Requisitos de Postulación
CREATE TABLE Requisitos (
    id_requisito INT AUTO_INCREMENT PRIMARY KEY,
    tipo_beneficio VARCHAR(100),
    descripcion TEXT
);

-- Tabla: Historial Postulaciones
CREATE TABLE Historial_Postulaciones (
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_persona INT,
    id_postulacion INT,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado_anterior VARCHAR(20),
    FOREIGN KEY (id_persona) REFERENCES Personas(id_persona),
    FOREIGN KEY (id_postulacion) REFERENCES Postulaciones(id_postulacion)
);

-- Tabla: Beneficios Entregados
CREATE TABLE Beneficios_Entregados (
    id_beneficio INT AUTO_INCREMENT PRIMARY KEY,
    id_persona INT,
    monto DECIMAL(10, 2),
    fecha_entrega TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    metodo_entrega VARCHAR(50),
    lugar_entrega VARCHAR(200),
    tipo_beneficio VARCHAR(100),
    FOREIGN KEY (id_persona) REFERENCES Personas(id_persona)
);

-- Tabla: Notificaciones
CREATE TABLE Notificaciones (
    id_notificacion INT AUTO_INCREMENT PRIMARY KEY,
    id_persona INT,
    tipo VARCHAR(50),
    mensaje TEXT,
    fecha_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_persona) REFERENCES Personas(id_persona)
);

-- Tabla: Orientación y Asesoría
CREATE TABLE Asesoria (
    id_asesoria INT AUTO_INCREMENT PRIMARY KEY,
    id_persona INT,
    tipo_asesoria VARCHAR(100),
    fecha_asesoria TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    medio_asesoria VARCHAR(50),
    detalle_asesoria TEXT,
    FOREIGN KEY (id_persona) REFERENCES Personas(id_persona)
);

-- Tabla: Seguridad y Auditoría
CREATE TABLE Auditoria (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_persona INT,
    accion VARCHAR(100),
    fecha_accion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip VARCHAR(15),
    descripcion TEXT,
    FOREIGN KEY (id_persona) REFERENCES Personas(id_persona)
);

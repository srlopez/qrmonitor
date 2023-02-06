# OSit QRmonitor

OSit QRmonitor es una app que funciona en Android y permite escanear códigos QR que tengamos pegados en los elementos core de nuestra organización, sea en servidores, cabinas de almacenamiento, switches, APs Wifi, SAIs... con el objetivo de visualizar en tiempo real sus datos, estado y rendimiento.

OSit QRmonitor obtiene la información del sistema de monitorización Centreon, por tanto, si dispones de tu infraestructura monitorizada (y eres feliz) podrás bajarte la app y usarla de manera gratuita YA. Es una app de código abierto, no tiene publicidad y viene sin soporte.

## Cómo funciona

Es muy simple, al abrir la app directamente mostrará la cámara del Android, con ella escanearemos un código QR que tengamos pegado en un dispositivo monitorizado con Centreon. En el momento de leer el código QR mostrará en pantalla el estado actual todos los _Servicios_ que tiene monitorizados el dispositivo (o _Host_).

## Qué necesitamos

Podremos usar cualquier generador de códigos QR para las pegatinas, como puedan ser webs que ofrecen dicho servicio gratuito. Al generar los códigos QR, tendremos que tener en cuenta que cada código QR devolverá una palabra únicamente, siendo esta, el nombre de su '_Host_' en Centreon. 

La versión inicial de OSit QRmonitor (v. 0.0.1) sólo permite conectar a Centreon mediante una conexión MySQL, por tanto, será necesario crear un usuario de lectura en la BD de Centreon y tener conectividad a ella.

## Qué podemos ver

Como indicamos, al escanear un código QR se mostrarán el estado de todos los ítems monitorizados en dicha máquina. Gracias a Centreon sabemos que podemos conocer la disponibilidad y rendimiento de nuestras máquinas, pues ahora, lo podemos ver en tiempo real y desde cualquier sitio, delante de una antena, de un switch y conocer el estado de sus interfaces, de un hipervisor y conocer su rendimiento, de sus MVs... en una impresora el estado de sus tóner

Si tenemos alguna alerta en algún _Servicio_ monitorizado en estado Warning o Crítical, éste se visualizará en pantalla en color Amarillo o Rojo.

Visualizaremos la dirección IP de la máquina escaneada.

Además campos de texto interesantes como puedan ser el número de serie de la máquina, la fecha de caducidad del contrato de mantenimiento... 

Interesante también la posibilidad de añadir URLs para el acceso con un click a la gestión del dispositivo.

## Ideas de uso

Ítems de ejemplo que podemos monitorizar en Centreon y visualizar con la app OSit QRmonitor:

*   Servidor: Uso de CPU, memoria, uso de disco, uso de red, estado de procesos, servicios, puertos... métricas de virtualización, estado del hardware,, actualizaciones pendientes del SO...
*   Switch: Uso CPU, memoria, estado y nombre de los puertos, así como su uso de tráfico de red, el estado del hardware...
*   AP Wifi: Uso de canales, experiencia del AP, clientes conectados, versión del firmware, tráfico de red por SSID, VLAN...
*   Firewall: Uso CPU, memoria, sesiones, estado de VPNs, estado, nombre y tráfico de sus interfaces, estado del hardware...
*   Cabina almacenamiento: Uso de CPU, memoria, tráfico de red SAN, volúmenes, estado del hardware, estado de los discos...
*   SAI: Estado y uso de las líneas de entrada/salida, consumos, carga del SAI, estado de carga de las baterías, alarmas...
*   Router: CPU, memoria, nombre y tráfico de sus interfaces, estado del hardware, latencias...
*   Impresora: Estado del hardware, errores en la impresora, uso de la bandeja de papel, estado del tóner, impresiones...
*   Raspberry Pi: Uso de CPU, memoria RAM, disco, tráfico de red, temperatura de la CPU, GPU...
*   Otros: Caducidad de certificados, estado de seguridad SSL, estado de copias de seguridad, SLA que ofrece la máquina, estado de sus BBDD, conocer las vulnerabilidades que tiene...

## Wiki

### Requisitos en Centreon

La v. 0.0.1 de OSit QRmonitor conecta directamente al motor de base de datos de Centreon, MySQL, por tanto, será necesario crear un usuario específico en la BD de Centreon, con permisos de lectura únicamente. Lo podremos hacer desde la shell de Centreon, conectando con el comando 'mysql' y las siguientes 2 instrucciones, deberemos indicar un usuario y una contraseña de nuestro interés.

    CREATE USER 'usuario_qr'@'%' IDENTIFIED BY 'CONTRASEÑA';
    grant SELECT ON centreon_storage.* to 'usuario_qr'@'%';

**Nota**: Si sabemos la dirección IP desde donde se van a conectar los Android, se podría indicar y no abrir a todo.

**Nota 2**: Desconocemos el versionado de Centreon necesario, está validado con una 22.10, entendemos que será compatible con versiones anteriores y futuras.


### Configurar la app

Una vez dispongamos de la app instalada en nuestro dispositivo Android, podremos configurar la conexión a MySQL desde los 3 puntos en la esquina superior derecha en la opción "DB Params",

<img src="img/app001b.jpeg" width="30%" height="30%">

Ahí deberemos establecer la dirección IP del servidor con la BD de Centreon, el puerto de conexión, así como los credenciales y el nombre de la base de datos.

<img src="img/app002.jpeg" width="30%" height="30%">

En las 'User Preferences', podremos configurarnos un Timeout donde especificaremos el tiempo que queremos que dure el QR en pantalla (en ms), por defecto 0, ilimitado. Así como la posibilidad de cambiar el color del tema de la app.

### Uso de la app

<img src="img/app01.jpeg" width="30%" height="30%">


Como sabemos ya, la finalidad de la app será escanear unos códigos QR que nos podremos auto generar y personalizar, Del QR obtendrá la palabra con el nombre del _Host_ monitorizado en Centreon. Será tan sencillo cómo escanear un QR.

<img src="img/app02.jpeg" width="30%" height="30%">


Y nos mostrará inmediatamente, el nombre del _Host_, su dirección IP y el resto de _Servicios_ monitorizados, así como su estado. Bastará con escanear otro código QR y la pantalla se actualizará automáticamente, o, podremos pulsar sobre el nombre del _Host_ en la parte superior izquierda y se limpiará la pantalla.

Si algún _Servicio_ del _Host_ estuviese en estado Warning o Crítical se visualizaría dicho servicio con otro color. Además, los _Servicios_ que devuelvan una URL nos permitirán pinchar en ellos y abrir el navegador directamente, por ejemplo a su web de gestión.

En la parte inferior se dispone de 3 botones, uno para cambiar de cámara, otro para pausar la imagen, y el tercero para activar el flash si es que lo necesitamos.

## FAQ

### Web para generar QR

Por ejemplo se puede usar QRCODEMONKEY: [https://www.qrcode-monkey.com](https://www.qrcode-monkey.com)

Leerá cualquier tipo de diseño de un código QR de formato TEXTO.

### Cómo genero un Servicio con URL

Se puede crear un _Servicio_ en Centreon que se llame por ejemplo 'Acceso a gestión' que simplemente devuelva una URL, y así podamos pinchar en ella desde la app OSit QRmonitor con el objetivo de acceder a la gestión del dispositivo desde nuestro Androd.

El _Servicio_ se apoyará de un Comando tan sencillo como la siguiente línea, y cada _Servicio_ que creemos, como Argumento le indicaremos la URL.

    /usr/bin/echo "$ARG1$"

### ¿Es seguro?

Sabemos que en esto de IT no hay nada seguro, así que queda a tu elección, simplemente se ha creado un usuario con permisos de lectura en tu BD de Centreon. 

Los códigos QR no revelan información confidencial, por lo que, si cualquier usuario (que no disponga de la app) escanea un código QR nuestro, mostrarán el nombre del dispositivo exclusivamente; los datos están en la BD.

### ¿Futuro?

¿Habrán nuevas versiones con nuevas funcionalidades?¿Habrán nuevas apps que hagan otras cosas molonguis? Quién sabe, alguna idea loca queda, pero... _tempus fugit_.

### Licenciamiento

Cómo indicamos OSit QRmonitor es gratuita y de código abierto, que podrá ser usada por cualquier persona o empresa.

Con una única condición, los proveedores de IT no tienen derecho de modificar el código de la app, ni para su uso particular, ni la de sus clientes; ni por supuesto vender la app o derivados de esta. ;-)

### Descarga

Para poder acceder al APK compilado e instalártelo en tu Android, podrás hacerlo desde aquí: https://www.bujarra.com/osit-qrmonitor

### Contacto

Estamos en http://www.openservices.eus

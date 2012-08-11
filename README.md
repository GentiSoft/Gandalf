
![You shall not pass](http://indebtfatshortbadteeth.files.wordpress.com/2012/04/you-shall-not-pass1.jpg)

Gandalf es un script en bash que se puede usar en el inicio del sistema, copiandolo a los rc o init (depende la distribución de linux), este redefine según archivos de configuración y algunos servicios.

# INSTALACION:

Hay 2 directorios, rc-file y etc, el contenido de etc tiene que ser copiado a /etc (el directorio con los archivos e configuración debe quedar /etc/gandalf), y el archivo "gandalf" dentro de rc-file tiene que ser copiado a /etc/rc.d o /etc/init.d, dependiendo de la distribución, luego se debera habilitar como servicio asi en el arranque del sistema se ejecutará, y se podra "stopear" o limpiar las reglas asi como modificar la configuracion y releer las reglas.

## DEBIAN

Luego de copiar etc/gandalf a /etc se debera copiar el archivo rc-file/gandalf a /etc/init.d

```
cp rc-file/gandalf /etc/init.d
```

una vez realizado esto se deberá habilitar con update.rc

```
update-rc.d gandalf defaults
```

y para correrlo la primera vez:

```
/etc/init.d/gandalf start
```

## ARCHLINUX

En Archlinux después de copiar el directorio de configuracion a /etc, se debe copiar rc-file gandalf a /etc/rc.d

```
cp rc-file/gandalf /etc/rc.d
```

Una vez copiado, añadiremos el "servicio" en el array de DAEMONS en el archivo /etc/rc.conf, que puede quedar asi:

```
DAEMONS=(syslog-ng network gandalf crond dbus sshd @cupsd)
```

Para correrlo la primera vez podemos hacer:

```
rc.d start gandalf 
```

#Configuración

El archivo principal es /etc/gandalf/gandalf.conf que cuenta con algunos parametros explicados en dicho archivo, como interface de red de salida a internet, hosts habilitados, interfaces sin restricciones y etc.

Luego existen los directorios /etc/gandalf/services-available y /etc/gandalf/services-enabled

Que contendra scripts que habiliten ciertos servicios, en el directorio available iran todos estos scripts, en el que al principio se podran definir las interfaces a usar, en el enabled habran links sinbolicos a estos, los que esten linkeados en enableds correran.


## PROBANDO LA CONFIGURACION DESDE MAQUINA REMOTA

Estas instalando gandalf en un servidor remoto por SSH y te equivocaste de interface! te olvidaste de habilitar el puerto 22!!! o no!! hard reset, chau uptime, servicio caido!! mi jefe se entera!!!

**No  te alarmes!**

Para probar la configuracion en este caso, el script puede recibir una orden "test" que aplicara las reglas a iptables pero 30 segundos después las borrará, esto sirve para probar la configuracion "on-line" y si falla algo y no se puede volver a acceder al equipo, solo hay que contarle un chiste de 30 segundos a tu jefe para que no haga F5 y vea que su web no anda, luego podras acceder y arreglar el problema.

# AUTOR

Yo, Oscar J. Gentilezza Arenas (tioscar@gmail.com), aunque me base en este articulo para las reglas: http://www.pello.info/filez/firewall/iptables.html

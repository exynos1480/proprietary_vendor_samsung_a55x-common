#! /vendor/bin/sh

SILENT_LOGGING_9900=/data/vendor/gps/silentGnssLogging
SILENT_LOGGING_ISSUETRACKER=/data/vendor/gps/silentGnssLoggingIssueTracker

PRODUCT_NAME=`getprop ro.product.odm.name`
DAEMONFILE=/vendor/bin/hw/gpsd_K44
FIRMWAREFILE=/vendor/firmware/gnss/firmware_signed_$PRODUCT_NAME.bin

if [[ $PRODUCT_NAME == *"kdi"* ]] ; then
	CONFIGFILE=/vendor/etc/gnss/gps.kdi.cfg
elif [[ $PRODUCT_NAME == *"dcm"* ]] ; then
	CONFIGFILE=/vendor/etc/gnss/gps.dcm.cfg
else
	CONFIGFILE=/vendor/etc/gnss/gps.cfg
fi

if [ -d "$SILENT_LOGGING_ISSUETRACKER" ] ; then
	if [[ $PRODUCT_NAME == *"kdi"* ]] ; then
		CONFIGFILE=/vendor/etc/gnss/gps.kdi.issuetracker.cfg
	elif [[ $PRODUCT_NAME == *"dcm"* ]] ; then
		CONFIGFILE=/vendor/etc/gnss/gps.dcm.issuetracker.cfg
	else 
		CONFIGFILE=/vendor/etc/gnss/gps.issuetracker.cfg
	fi
fi

if [ -d "$SILENT_LOGGING_9900" ] ; then 
	if [[ $PRODUCT_NAME == *"kdi"* ]] ; then
		CONFIGFILE=/vendor/etc/gnss/gps.kdi.debug.cfg
	elif [[ $PRODUCT_NAME == *"dcm"* ]] ; then
		CONFIGFILE=/vendor/etc/gnss/gps.dcm.debug.cfg
	else 
		CONFIGFILE=/vendor/etc/gnss/gps.debug.cfg
	fi
fi

exec $DAEMONFILE -c $CONFIGFILE -b $FIRMWAREFILE

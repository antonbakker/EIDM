// =================================== GOOGLEMAPS COORDINATES =================================== //

IF vLoadMapCoordinates=1 THEN

    IF vProduct = 'Qlikview' THEN
TRACE # Load Google maps data for Qlikview;
    AddressCoordinates:
        LOAD 
            AUTONUMBER(%Location_key, 'Location_key' ) AS %Location_key,
            status, 
            type, 
            formatted_address, 
            REPLACE(latitude,'.',',') AS latitude,
            REPLACE(longitude,'.',',') AS longitude
            //,Country AS [Address Country]
            FROM [$(vDirectory_Google)\*AddressCoordinates.qvd](qvd)
            //WHERE WILDMATCH(formatted_address,'*Netherlands')	
            ;
     ELSE
TRACE # Load Google maps data for Qlik Sense;
     AddressCoordinates:
        LOAD 
            AUTONUMBER(%Location_key, 'Location_key' ) AS %Location_key,
            status, 
            type, 
            formatted_address, 
            REPLACE(latitude,'.',',') AS latitude,
            REPLACE(longitude,'.',',') AS longitude,
            GeoMakePoint(REPLACE(latitude,'.',','), REPLACE(longitude,'.',',')) AS AddressPoint 
            //,Country AS [Address Country]
            FROM [$(vDirectory_Google)\*AddressCoordinates.qvd](qvd)
            //WHERE WILDMATCH(formatted_address,'*Netherlands')	
            ;
     END IF	 
    
ELSE 
TRACE # Load no google maps data;

AddressCoordinates:
	LOAD * INLINE [
		%Location_key
		vUnkownDimension
	];
	
ENDIF
max_zoom_level = 17; //maximum value 17 


// Field required for calcualting best zoom level
_zoom_level:
Load RecNo( ) as _zoom_level autogenerate(max_zoom_level);



maptype:
LOAD * INLINE [
    maptype
    roadmap
	mobile
	satellite
	terrain
	hybrid 
];


PROGRAM POU
VAR
	//Brazo neumatico
		//Actuadores
	MovingX:REAL;
	MovingY:REAL;
	MovingZ:REAL;
	
	Rotate:BOOL;
	Grab:BOOL;
		//Sensores
	Xpos:REAL;
	Ypos:REAL;
	Zpos:REAL;
	degrees90:BOOL;
	Itemgdetect:BOOL;
	
	//Cintas
	Cinta1:BOOL;
	Cinta2:BOOL;
	Cinta3:BOOL;
	Sensorpieza:BOOL;
	Sensorpalet:BOOL;
	Sensorsalida0:BOOL;
	Sensorsalida1:BOOL;
	
	//Panel de mandos
		//Entradas
	Startbutton:BOOL;
	Stopbutton:BOOL;
	Resetbutton:BOOL;
	SETA:BOOL;
		//Salidas
	Startlight:BOOL;
	Stoplight:BOOL;
	Resetlight:BOOL;
	Counter:INT;
	
	PasoActual:INT:=0;
	FalloEmergencia:BOOL:=FALSE;
	MiTimer:TON;
	TiempoAgarre:TIME:=T#500MS;
	RamaA:INT:=0;
	RamaB:INT:=0;
	Apagado:BOOL;
	Boxremover:BOOL;
	EjecutadoPrimerCiclo : BOOL := FALSE;
END_VAR

//BORRADOR

Rotate:=FALSE;
Cinta1:=FALSE;
Cinta2:=FALSE;
Cinta3:=FALSE;
ResetLight:=TRUE;
Boxremover:=FALSE;

IF NOT EjecutadoPrimerCiclo THEN
    PasoActual := 0;          
    RamaA := 0;               
    RamaB := 0;
    FalloEmergencia := FALSE; 
    
    EjecutadoPrimerCiclo := TRUE; 
    RETURN; 
END_IF;

IF NOT SETA THEN
	FalloEmergencia:=TRUE;	
END_IF

IF NOT Stopbutton THEN
	Apagado:=TRUE;
END_IF

IF FalloEmergencia THEN
	
	MovingX:=0;
	MovingY:=0;
	MovingZ:=0;
	Rotate:=FALSE;
	Grab:=FALSE;
	Cinta1:=FALSE;
	Cinta2:=FALSE;
	Startlight:=FALSE;
	Stoplight:=TRUE;
	ResetLight:=TRUE;
	Boxremover:=FALSE;
	
	IF SETA AND Resetbutton THEN
		FalloEmergencia:=FALSE;
	END_IF
	
ELSE
	CASE PasoActual OF
		0:
			IF Startbutton THEN
				Stoplight:=TRUE;
				PasoActual:=1;
			END_IF
		1:
			Startlight:=TRUE;
			Stoplight:=FALSE;
			
			IF Sensorpieza THEN
				Cinta2:=TRUE;
			END_IF
			
			IF Sensorpalet THEN
				Cinta1:=TRUE;
			END_IF
			
			IF NOT Sensorpalet AND NOT Sensorpieza THEN
				PasoActual:=2;
			END_IF
		2:
			MovingX:=8;
			MovingY:=5;
			
			IF Xpos>=7.8 AND Ypos>=4.8 AND NOT Itemgdetect THEN
				PasoActual:=3;
			END_IF
		3:
			MovingZ:=5.4;
			
			IF Zpos>=5.3 THEN
				Grab:=TRUE;
			END_IF
			
			MiTimer(IN:=Grab, PT:=TiempoAgarre);
			
			IF MiTimer.Q THEN
				MiTimer(IN:=FALSE);
				PasoActual:=4;
			END_IF
		4:
		
			CASE RamaA OF
				0:
					IF RamaB>=1 THEN
						Cinta2:=TRUE;
					
						IF NOT SensorPieza THEN
							RamaA:=1;
						END_IF
					END_IF
			END_CASE
		
			CASE RamaB OF
				0:
					MovingZ:=0;
					IF Zpos<=0.2 THEN
						MovingX:=3;
						MovingY:=3;
			
						IF Xpos<=3.1 AND Ypos<=3.1 THEN
							RamaB:=1;
						END_IF
					END_IF
					
				1:
					MovingZ:=5.4;
			
					IF Zpos>=5.3 THEN
						Grab:=FALSE;
					END_IF
			
					MiTimer(IN:= NOT Grab, PT:=TiempoAgarre);
			
					IF MiTimer.Q THEN
						MiTimer(IN:=FALSE);
						RamaB:=2;
					END_IF
				2:
					MovingZ:=0;
					IF Zpos<=0.2 THEN
						MovingX:=8;
						MovingY:=5;
			
						IF Xpos>=7.8 AND Ypos>=4.9 AND NOT Itemgdetect THEN
							RamaB:=3;
						END_IF
					END_IF
					
			END_CASE
			
			IF RamaA=1 AND RamaB=3 THEN
				PasoActual:=5;
			END_IF
		5:
			RamaA:=0;
			RamaB:=0;
			MovingZ:=5.4;
			
			IF Zpos>=5.3 THEN
				Grab:=TRUE;
			END_IF
			
			MiTimer(IN:=Grab, PT:=TiempoAgarre);
			
			IF MiTimer.Q THEN
				MiTimer(IN:=FALSE);
				PasoActual:=6;
			END_IF		
		6:
		
			CASE RamaA OF
				0:
					IF RamaB>=1 THEN
						Cinta2:=TRUE;
					
						IF NOT SensorPieza THEN
							RamaA:=1;
						END_IF
					END_IF
					
			END_CASE
		
			CASE RamaB OF
				0:
					MovingZ:=0;
					IF Zpos<=0.2 THEN
						MovingX:=3;
						MovingY:=6.5;
			
						IF Xpos<=3.1 AND Ypos>=6.4 THEN
							RamaB:=1;
						END_IF
					END_IF
					
				1:
					MovingZ:=5.4;
			
					IF Zpos>=5.3 THEN
						Grab:=FALSE;
					END_IF
			
					MiTimer(IN:= NOT Grab, PT:=TiempoAgarre);
			
					IF MiTimer.Q THEN
						MiTimer(IN:=FALSE);
						RamaB:=2;
					END_IF
				2:
					MovingZ:=0;
					IF Zpos<=0.2 THEN
						MovingX:=8;
						MovingY:=5;
			
						IF Xpos>=7.9 AND Ypos>=4.9 AND NOT Itemgdetect THEN
							RamaB:=3;
						END_IF
					END_IF
					
			END_CASE
			
			IF RamaA=1 AND RamaB=3 THEN
				PasoActual:=7;
			END_IF	
		7:
			RamaA:=0;
			RamaB:=0;
			MovingZ:=5.4;
			
			IF Zpos>=5.3 THEN
				Grab:=TRUE;
			END_IF
			
			MiTimer(IN:=Grab, PT:=TiempoAgarre);
			
			IF MiTimer.Q THEN
				MiTimer(IN:=FALSE);
				PasoActual:=8;
			END_IF		
		8:
			MovingZ:=0;
			IF Zpos<=0.2 THEN
				Rotate:=TRUE;
				MovingX:=3;
				IF degrees90 AND Xpos<=3.1 THEN
					PasoActual:=9;
				END_IF		
			END_IF
			
		9:
			MovingZ:=5.4;
			Rotate:=TRUE;
			
			IF Zpos>=5.3 THEN
				Grab:=FALSE;
			END_IF
			
			MiTimer(IN:= NOT Grab, PT:=TiempoAgarre);
			
			IF MiTimer.Q THEN
				MiTimer(IN:=FALSE);
				PasoActual:=10;
			END_IF
		10:
			MovingZ:=0;
			IF Zpos<=3 THEN
				MovingX:=0;
				MovingY:=0;
				Cinta1:=TRUE;
				Cinta3:=TRUE;
			
				IF NOT Sensorsalida0 THEN
					PasoActual:=11;
				END_IF	
			END_IF
		11:
			Cinta3:=TRUE;
		
			IF NOT Sensorsalida1 THEN
				PasoActual:=12;
			END_IF
		
		12:
			Boxremover:=TRUE;
			Cinta3:=TRUE;
			IF Sensorsalida1 THEN
				IF Apagado THEN
					Apagado:=FALSE;
					Counter:=0;
					PasoActual:=0;
				ELSE
					Counter:= Counter+1;
					PasoActual:=1;
				END_IF
			END_IF
			
	END_CASE


END_IF

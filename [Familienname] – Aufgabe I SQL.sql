-- Name:
USE [BikersWorld]

--Beginner (je 1 Punkt)

	--1 Tours for Beginners (1P)
	--Geben Sie alle Tour (TourId, Name, Route, Duration) aus, welche k�rzer als 3 Stunden dauern.
	--Anmerkung: F�hren Sie die Aufgabe in einem SELECT aus.
Select [TourId]
		,[Name]
		,[Route]
		,[Duration]
from [BikersWorld].[dbo].[Tour]
where [Duration] >= '03:00:00.0000000';

SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS 
  WHERE table_name = 'Tour' AND COLUMN_NAME = 'Duration';

	--2 Top Rated (1P)
	--Geben Sie alle Tour (TourId, Name) und deren durchschnittliches Rating (Points) absteigend sortiert aus.
	--Anmerkung: F�hren Sie die Aufgabe in einem SELECT aus.


Select Tour.TourId
		,[Name],
		avg(Points) as avg_rating
from [BikersWorld].[dbo].[Tour]
join [BikersWorld].[dbo].[Rating]
on Tour.TourId = Rating.TourId
group by Tour.TourId,[Name]
order by avg_rating desc

	--3 Owned Bikes (1P)
	--Geben Sie alle User(UserId, FirstName, LastName, UserName, Birthday) und ihre ihnen geh�renden Bikes(Name, Description, FrameSize) aus, bei welchen die Description nicht leer ist.
	--Anmerkung: F�hren Sie die Aufgabe in einem SELECT aus.

Select [User].UserId, FirstName, LastName, UserName, Birthday,Name, Description, FrameSize
from [dbo].[User]
join UserHasBike
on [User].UserId = UserHasBike.UserId
join Bike
on UserHasBike.BikeId =Bike.BikeId
where Description is not null;

--Advanced (je 2 Punkte)
	--Ab diesem Level dokumentieren Sie alle Probleme oder unsauberen Umsetzungen, welche ihnen in der Datenbank auffallen. Geben Sie diese Kommentare und Anmerkungen mit ab.
	
	--4 Fake Reviews (2P)
	--Geben Sie alle User (UserId, FirstName, LastName, UserName) und die zugeh�rigen Rating (Name, Points) Informationen aus, welche Touren bewertet haben, zu denen es keinen passenden Activities Eintrag gibt.
	--Anmerkung: F�hren Sie die Aufgabe in einem SELECT aus.


Select [User].UserId, FirstName, LastName, UserName, Points, Tour.Name
from [dbo].[Participation]
right join Activity
on Participation.ActivityId = Activity.ActivityId
join Tour
on Activity.TourId = Tour.TourId
join Rating
on Tour.TourId = Rating.TourId
join [User]
on Rating.UserId = [User].UserId
where Participation.ActivityId IS Null

	--5 Faster than planned (2P)
	--Geben Sie alle Tour (TourId, Name, Route, Duration (in MILLISECOND)) und die zugeh�rigen Durchschnittszeiten derer Activities (in MILLISECOND) f�r alle Touren aus die schneller als die hinterlegte Duration absolviert wurden. 
	--Anmerkung: F�hren Sie die Aufgabe in einem SELECT aus.

	--6 Statistics (2P)
	--Geben Sie alle User (UserId, FirstName, LastName), City (Name), State (Name), die Anzahl der Bikes in deren Besitz, die Anzahl der abgegebenen Bewertungen (Rating) und die Anzahl der teilgenommen Activities, absteigend geordnet nach diesen aus. Es sollen nur User deren FirstName gesetzt ist ber�cksichtigt werden.
	--Anmerkung: F�hren Sie die Aufgabe in einem SELECT aus.

	--7 Denormalization I (2P)
	--Erstellen Sie eine Tabelle ActivityEvaluation, welche alle Informationen aus User, Participation, Activity und Tour in der zusammenpassenden Weise beinhaltet. Erstellen Sie dazu zuerst die Tabelle und f�gen Sie dann alle Eintr�ge der durchgef�hrten Activities ein. Ziel der Aufgabe ist es zu denormalisieren und die Daten so aufzubereiten, damit zuk�nftig schneller darauf zugegriffen werden kann.
	--Anmerkung: F�gen Sie die Daten aus den Tabellen mit maximal einem Statement in die Tabelle ActivityEvaluation ein. �berlegen Sie sich f�r die Tabelle einen sinnvollen Primary Key und legen diesen mit an.

	--8 Comparison (2P)
	--Erstellen Sie zwei Auswertungen. Eine basierend auf der zuvor angelegten Tabelle ActivityEvaluation und eine weitere aus einem Join von User, Participation, Activity und Tour. Beide Auswertungen sollen zeigen, wie oft jeder Benutzer welche Tour gemacht hat. Dabei sollen nur User angezeigt werden,  die eine Tour mindestens zweimal gemacht haben. Ordnen sie die Ausgabe zuerst nach der Anzahl der Activity absteigend, und als zweiten Sortierparameter nach dem Namen der Tour aufsteigend.
	--Zus�tzlich zu den SELECTS stellen Sie einen Vergleich der Execution Plans an und dokumentieren sie ihre Analyse in ein paar S�tzen.
	--Anmerkung: F�hren Sie jede Auswertung in einem einzelnen SELECT aus.

	--9 Keep it up to date I (2P)
	--Erstellen Sie einen Trigger TG_CopyToActivityEvaluation welcher sicherstellt, dass beim Erstellen eines neuen Datensatzes in der Tabelle Participation,  dieser Datensatz vollst�ndig und korrekt in ActivityEvaluation �berf�hrt wird. Testen Sie den Trigger mit einem INSERT in die Tabelle Participation. Achten Sie dabei darauf, dass der Trigger sinnvoll eingesetzt wird.

	--10 Denormalization II (2P)
	--Erstellen Sie eine Tabelle BikeEvaluation, welche alle Informationen aus User, UserHasBike, Bike und der jeweiligen konkreter Klasse in der zusammenpassenden Weise beinhaltet. Erstellen Sie dazu zuerst die Tabelle und f�gen Sie dann alle Eintr�ge der besessenen Bikes ein. Ziel der Aufgabe ist es zu denormalisieren und die Daten so aufzubereiten, damit zuk�nftig schneller darauf zugegriffen werden kann.
	--Anmerkung: F�gen Sie die Daten aus den Tabellen mit maximal einem Statement in die Tabelle BikeEvaluation ein. �berlegen Sie sich f�r die Tabelle einen sinnvollen Primary Key und legen diesen mit an.

	--11 Keep it up to date II (2P)
	--Erstellen Sie einen Trigger TG_CopyToBikeEvaluation welcher sicherstellt, dass beim Hinzuf�gen eines neuen Datensatzes in die Tabelle UserHasBike, dieser Eintrag korrekt und vollst�ndig in BikeEvaluation �berf�hrt wird. Testen Sie den Trigger mit einem INSERT in die Tabelle UserHasBike. Achten Sie dabei darauf, dass der Trigger sinnvoll eingesetzt wird.

	--12 New Bike (2P)
	--Erstellen Sie eine Procedure AddNewBike, welche verwendet werden kann um ein neues Bike und deren konkrete Klasse in der Datenbank anzulegen. Die Procedure soll als R�ckgabewert die BikeId des neu angelegten Bikes enthalten. Achten Sie dabei auf Fehlerbehandlung, falls die Procedure nicht richtig aufgerufen wird. Dokumentieren Sie zus�tzlich zum Code der Procedure noch ein paar Beispielaufrufe.

	--13 Country Roads (2p)
	--Erstellen Sie eine Table-Function GetDrivenStates, welche eine ActivityId �bernimmt und f�r diese ermitteltet durch welche States diese f�hrt und wie lange die zur�ckgelegte Distanz der Route in diesen States ist. Geben Sie dazu den StateName, den CountryName und die LenghtOfTour pro State in der Ergebnisstabelle aus.

--Advanced (je 3 Punkte)
	--14 BikeHistory (3P)
	--Erstellen Sie eine Tabelle BikeHistory (UserId, StartTime, EndTime, BikeCounter), welche eine historische �bersicht �ber die Anzahl der besessenen Bikes pro User liefert. Nachdem Sie die Tabelle erstellt haben, bef�llen Sie diese mittels eines Cursors mit den Informationen aus UserHasBike. Ziel ist es dabei, dass in der Tabelle ersichtlich ist, in welchem Zeitraum welcher Benutzer wie viele Bikes besessen hat. F�gen Sie dazu den ben�tigten Code in den bereitgestellten BEGIN-END-Block nach �-- Code einf�gen� ein.
	--Anmerkung: Muss zu �bungszwecken mit einem Cursor durchgef�hrt werden.
	BEGIN
	--	-- Code einf�gen
	END

	--15 Keep the History alive (3P)
	--Erstellen Sie einen Trigger TG_UpdateBikeHistory, welcher sicherstellt, dass wenn Datens�tze in der Tabelle UserHasBike gel�scht oder eingef�gt werden, die korrekten Informationen in der Tabelle BikeHistory nachgezogen werden. Testen Sie den Trigger mit mindestens drei INSERTS und einem DELETE in die Tabelle UserHasBike. Achten Sie dabei darauf, dass der Trigger sinnvoll eingesetzt wird.

	--16 The last one (3P)
	--Erstellen Sie eine Table-Function TimeDistanceStatistics, welche eine Flag �bernimmt und abh�ngig von dieser das gew�nschte Ergebnis liefert. Die Flag beginnt mit einem Qualifier, welcher angibt, wie die Daten gefiltert werden, gefolgt von einer Id. M�gliche Qualifier sind ein t f�r das Filtern anhand der Tour, oder ein u f�r das Filtern nach dem User.
	--Qualifier und ID wird kombiniert in einem VARCHAR �bergeben. Abh�ngig vom Qualifier wird eine Auswertung erstellt welcher aufschl�sselt in welchem 
	--Month (als Zahl), Month (als Monatsname), Year, gefahrenen Distanz (in diesem Qualifier/Zeitintervall), Anzahl der Activitys (in diesem Qualifier/Zeitintervall) und durch wie viele 
	--States bei diesen Activitys gefahren wurde (in diesem Qualifier/Zeitintervall). 
	--Achten Sie dabei darauf, wie sie mit Fehleingaben des Flags umgehen. Dokumentieren Sie zus�tzlich zur Table-Function ein paar Beispielaufrufe.
	--Beispielparameter
	--'t2' => Steht f�r die Tour mit der TourId 2
	--'u2' => Steht f�r den User mit der UserId 2

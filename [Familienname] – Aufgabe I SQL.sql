-- Name:
USE [BikersWorld]

--Beginner (je 1 Punkt)

	--1 Tours for Beginners (1P)
	--Geben Sie alle Tour (TourId, Name, Route, Duration) aus, welche kürzer als 3 Stunden dauern.
	--Anmerkung: Führen Sie die Aufgabe in einem SELECT aus.
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
	--Anmerkung: Führen Sie die Aufgabe in einem SELECT aus.


Select Tour.TourId
		,[Name],
		avg(Points) as avg_rating
from [BikersWorld].[dbo].[Tour]
join [BikersWorld].[dbo].[Rating]
on Tour.TourId = Rating.TourId
group by Tour.TourId,[Name]
order by avg_rating desc

	--3 Owned Bikes (1P)
	--Geben Sie alle User(UserId, FirstName, LastName, UserName, Birthday) und ihre ihnen gehörenden Bikes(Name, Description, FrameSize) aus, bei welchen die Description nicht leer ist.
	--Anmerkung: Führen Sie die Aufgabe in einem SELECT aus.

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
	--Geben Sie alle User (UserId, FirstName, LastName, UserName) und die zugehörigen Rating (Name, Points) Informationen aus, welche Touren bewertet haben, zu denen es keinen passenden Activities Eintrag gibt.
	--Anmerkung: Führen Sie die Aufgabe in einem SELECT aus.


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
	--Geben Sie alle Tour (TourId, Name, Route, Duration (in MILLISECOND)) und die zugehörigen Durchschnittszeiten derer Activities (in MILLISECOND) für alle Touren aus die schneller als die hinterlegte Duration absolviert wurden. 
	--Anmerkung: Führen Sie die Aufgabe in einem SELECT aus.

	--6 Statistics (2P)
	--Geben Sie alle User (UserId, FirstName, LastName), City (Name), State (Name), die Anzahl der Bikes in deren Besitz, die Anzahl der abgegebenen Bewertungen (Rating) und die Anzahl der teilgenommen Activities, absteigend geordnet nach diesen aus. Es sollen nur User deren FirstName gesetzt ist berücksichtigt werden.
	--Anmerkung: Führen Sie die Aufgabe in einem SELECT aus.

	--7 Denormalization I (2P)
	--Erstellen Sie eine Tabelle ActivityEvaluation, welche alle Informationen aus User, Participation, Activity und Tour in der zusammenpassenden Weise beinhaltet. Erstellen Sie dazu zuerst die Tabelle und fügen Sie dann alle Einträge der durchgeführten Activities ein. Ziel der Aufgabe ist es zu denormalisieren und die Daten so aufzubereiten, damit zukünftig schneller darauf zugegriffen werden kann.
	--Anmerkung: Fügen Sie die Daten aus den Tabellen mit maximal einem Statement in die Tabelle ActivityEvaluation ein. Überlegen Sie sich für die Tabelle einen sinnvollen Primary Key und legen diesen mit an.

	--8 Comparison (2P)
	--Erstellen Sie zwei Auswertungen. Eine basierend auf der zuvor angelegten Tabelle ActivityEvaluation und eine weitere aus einem Join von User, Participation, Activity und Tour. Beide Auswertungen sollen zeigen, wie oft jeder Benutzer welche Tour gemacht hat. Dabei sollen nur User angezeigt werden,  die eine Tour mindestens zweimal gemacht haben. Ordnen sie die Ausgabe zuerst nach der Anzahl der Activity absteigend, und als zweiten Sortierparameter nach dem Namen der Tour aufsteigend.
	--Zusätzlich zu den SELECTS stellen Sie einen Vergleich der Execution Plans an und dokumentieren sie ihre Analyse in ein paar Sätzen.
	--Anmerkung: Führen Sie jede Auswertung in einem einzelnen SELECT aus.

	--9 Keep it up to date I (2P)
	--Erstellen Sie einen Trigger TG_CopyToActivityEvaluation welcher sicherstellt, dass beim Erstellen eines neuen Datensatzes in der Tabelle Participation,  dieser Datensatz vollständig und korrekt in ActivityEvaluation überführt wird. Testen Sie den Trigger mit einem INSERT in die Tabelle Participation. Achten Sie dabei darauf, dass der Trigger sinnvoll eingesetzt wird.

	--10 Denormalization II (2P)
	--Erstellen Sie eine Tabelle BikeEvaluation, welche alle Informationen aus User, UserHasBike, Bike und der jeweiligen konkreter Klasse in der zusammenpassenden Weise beinhaltet. Erstellen Sie dazu zuerst die Tabelle und fügen Sie dann alle Einträge der besessenen Bikes ein. Ziel der Aufgabe ist es zu denormalisieren und die Daten so aufzubereiten, damit zukünftig schneller darauf zugegriffen werden kann.
	--Anmerkung: Fügen Sie die Daten aus den Tabellen mit maximal einem Statement in die Tabelle BikeEvaluation ein. Überlegen Sie sich für die Tabelle einen sinnvollen Primary Key und legen diesen mit an.

	--11 Keep it up to date II (2P)
	--Erstellen Sie einen Trigger TG_CopyToBikeEvaluation welcher sicherstellt, dass beim Hinzufügen eines neuen Datensatzes in die Tabelle UserHasBike, dieser Eintrag korrekt und vollständig in BikeEvaluation überführt wird. Testen Sie den Trigger mit einem INSERT in die Tabelle UserHasBike. Achten Sie dabei darauf, dass der Trigger sinnvoll eingesetzt wird.

	--12 New Bike (2P)
	--Erstellen Sie eine Procedure AddNewBike, welche verwendet werden kann um ein neues Bike und deren konkrete Klasse in der Datenbank anzulegen. Die Procedure soll als Rückgabewert die BikeId des neu angelegten Bikes enthalten. Achten Sie dabei auf Fehlerbehandlung, falls die Procedure nicht richtig aufgerufen wird. Dokumentieren Sie zusätzlich zum Code der Procedure noch ein paar Beispielaufrufe.

	--13 Country Roads (2p)
	--Erstellen Sie eine Table-Function GetDrivenStates, welche eine ActivityId übernimmt und für diese ermitteltet durch welche States diese führt und wie lange die zurückgelegte Distanz der Route in diesen States ist. Geben Sie dazu den StateName, den CountryName und die LenghtOfTour pro State in der Ergebnisstabelle aus.

--Advanced (je 3 Punkte)
	--14 BikeHistory (3P)
	--Erstellen Sie eine Tabelle BikeHistory (UserId, StartTime, EndTime, BikeCounter), welche eine historische Übersicht über die Anzahl der besessenen Bikes pro User liefert. Nachdem Sie die Tabelle erstellt haben, befüllen Sie diese mittels eines Cursors mit den Informationen aus UserHasBike. Ziel ist es dabei, dass in der Tabelle ersichtlich ist, in welchem Zeitraum welcher Benutzer wie viele Bikes besessen hat. Fügen Sie dazu den benötigten Code in den bereitgestellten BEGIN-END-Block nach „-- Code einfügen“ ein.
	--Anmerkung: Muss zu Übungszwecken mit einem Cursor durchgeführt werden.
	BEGIN
	--	-- Code einfügen
	END

	--15 Keep the History alive (3P)
	--Erstellen Sie einen Trigger TG_UpdateBikeHistory, welcher sicherstellt, dass wenn Datensätze in der Tabelle UserHasBike gelöscht oder eingefügt werden, die korrekten Informationen in der Tabelle BikeHistory nachgezogen werden. Testen Sie den Trigger mit mindestens drei INSERTS und einem DELETE in die Tabelle UserHasBike. Achten Sie dabei darauf, dass der Trigger sinnvoll eingesetzt wird.

	--16 The last one (3P)
	--Erstellen Sie eine Table-Function TimeDistanceStatistics, welche eine Flag übernimmt und abhängig von dieser das gewünschte Ergebnis liefert. Die Flag beginnt mit einem Qualifier, welcher angibt, wie die Daten gefiltert werden, gefolgt von einer Id. Mögliche Qualifier sind ein t für das Filtern anhand der Tour, oder ein u für das Filtern nach dem User.
	--Qualifier und ID wird kombiniert in einem VARCHAR übergeben. Abhängig vom Qualifier wird eine Auswertung erstellt welcher aufschlüsselt in welchem 
	--Month (als Zahl), Month (als Monatsname), Year, gefahrenen Distanz (in diesem Qualifier/Zeitintervall), Anzahl der Activitys (in diesem Qualifier/Zeitintervall) und durch wie viele 
	--States bei diesen Activitys gefahren wurde (in diesem Qualifier/Zeitintervall). 
	--Achten Sie dabei darauf, wie sie mit Fehleingaben des Flags umgehen. Dokumentieren Sie zusätzlich zur Table-Function ein paar Beispielaufrufe.
	--Beispielparameter
	--'t2' => Steht für die Tour mit der TourId 2
	--'u2' => Steht für den User mit der UserId 2

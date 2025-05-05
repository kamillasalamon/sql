# 8. gyakorlat

## Előkészületek

### MongoDB
+ Regisztráljunk a MongoDB Atlas oldalán (https://www.mongodb.com/cloud/atlas/register)
+ Telepítsük fel a MongoDB Compass programot (csak saját magunknak)

+ Opcionálisan: A VS CODE-ban adjuk hozzá a MongoDB for VS Code bővítményt

A megoldásokat - ahol kódot kell írni - másoljuk be a ```js és a ``` közötti részbe


## Feladatok

```js
//zh gyakorló feladatok
//1. Sample_mflix adatbázisból users gyűjtemény lekérdezése, csak a felhasználók neve és email címe jelenjen meg, email cím tartalmazza a .com karaktersorozatot
use sample_mflix
db.users.find(
  { email: /.*\.com.*/ },
  { name: 1, email: 1, _id: 0 }
)

//2. Műfajok küzöl legelső a Short, év 1945 és 1970 között, csak cím és év, sorbarendezés év és cím alapján
use sample_mflix
db.movies.find(
  {
    "genres.0": "Short",
    year: { $gte: 1945, $lte: 1970 }
  },
  {
    title: 1,
    year: 1,
    _id: 0
  }
).sort({ year: 1, title: 1 })

//3.
//SELECT year, AVG(num_mflix_comments)
//FROM movies
//WHERE runtime BETWEEN 50 and 100
//GROUP BY year

use sample_mflix
db.movies.aggregate([
  {
    $match: {
      runtime: { $gte: 50, $lte: 100 }
    }
  },
  {
    $group: {
      _id: "$year",
      avgComments: { $avg: "$num_mflix_comments" }
    }
  },
  {
    $sort: { _id: 1 }
  }
])

```

1.	Lépjen be a MongoPlayground oldalára, majd a melléklet 1. pontjában szereplő gyűjteményt másolja be a Configuration részbe!
a Készítsen lekérdezést, amely csak az user_id, firstName és lastname oszlopokat jeleníti meg!

```js
db.collection.find(
  {},
  { user_id: 1, firstName: 1, lastName: 1, _id: 0 }
)

```


2.	A MongoPlayground-on az előző feladatban létrehozott gyűjteményből kérdezze le a Grace keresztnevű felhasználó email-címét és jelszavát (csak ez a két mező jelenjen meg)!

```js
db.collection.find(
  { firstName: "Grace" },
  { email: 1, password: 1, _id: 0 }
)

```


3. Lépjen be a MongoDB Atlas-ba, majd értelemszerűen hozzon létre új szervezetet, projektet és cluster-t! Válasszuk a **Free** lehetőséget!
   
a. A Load sample Dataset lehetőség legyen bejelölve    (A dataset betöltése több percet is igénybe vehet)
b. Kattintson a Browse Collections gombra!
c. Ha nem jelenik meg a sample_training adatbázis, akkor a MongoDB Compass-ban hozzuk létre, és importáljuk a grades.json és a trips.json gyűjteményeket!

OPCIONÁLISAN: a feladat a MongoDB Compass-ból vagy a VS Code-ból kiidulva is megoldható

4.  A sample_training adatbázis grades gyűjteményből kérdezze le a 339-es azonosítójú osztály eredményeit!

a. A listában csak azok a dokumentumok jelenjenek meg, ahol a tanuló azonosítója 100 alatt van!

   
```js
db.grades.find(
  {
    class_id: 339,
    student_id: { $lt: 100 }
  }
)

```

OPCIONÁLISAN: a feladat a MongoDB Compass-ban, a VS Code-ban vagy a MongoDB Shell-ben is megoldható

5. A MongoDB Atlas-ban a + Create Database gomb lenyomásával  hozzunk létre új adatbázist Gyak8 néven, azon belül pedig egy új gyűjteményt szemelyek néven! A létrehozás után tegye aktuálissá a Gyak8.szemelyek gyűjteményt!
   
a. Az Insert Document gomb lenyomása után szúrjunk be új dokumentumot a szemelyek gyűjteménybe a következő tartalommal (értéknek mindenhova a saját adatait adja meg):  neptunkod, nev,  evfolyam
b. A neptunkod legyen string típusú
c. A név két mezőből álljon: vezeteknev és keresztnev (Object típus)
d. Az evfolyam egész szám legyen (Int32)

OPCIONÁLISAN: a feladat a MongoDB Compass-ban, a VS Code-ban vagy a MongoDB Shell-ben is megoldható


6. Indítsa el a MongoDB Compass alkalmazást, majd csatlakozzon a MongoDB cluster-hez! 


Ha korábban sikerült a kapcsolódás, akkor baloldalt a Recent részben kiválaszthatja a kapcsolatot
Sikertelen kapcsolat esetén a baloldalon lévő Network Access részben adja hozzá az aktuális IP-címét a tűzfal kivételekhez!
a. Hozzon létre új adatbázist Gyak_compass néven, azon belül egy új gyújteményt receptek néven!
b. A receptek gyűjteménybe importálja be a 2. melléklet tartalmát (Add data / Import File, majd Select File, végül Import)!

OPCIONÁLISAN: a feladat a VS Code-ban is megoldható


7. A MongoDB Compass segítségével kérdezze le az előző feladatban létrehozott receptek gyűjtemény azon dokumentumait, amelyre teljesül:

a. A lájkok száma több, mint 2!
b.  A lista legyen sorbarendezve a főzési idő szerint csökkenő sorrendben! (A rendezés funkció az Options gomb lenyomása után érhető el)
c. A listában ne jelenjenek meg az ingredients és a rating mezők (Project szakasznál kell beállítani)!

```js
db.recipes.find(
  { "likes": { "$gt": 2 } },
  { "ingredients": 0, "rating": 0 }
).sort({ "cooking_time": -1 })

```

OPCIONÁLISAN: a feladat a VS Code-ban vagy a MongoDB Shell-ben is megoldható

8. Az előző feladatban létrehozott lekérdezésre hajtsa végre az Explain Plan funkciót!

```js
db.recipes.find(
  { likes: { $gt: 2 } },
  { ingredients: 0, rating: 0 }
).sort({ cooking_time: -1 }).explain("executionStats")

```

OPCIONÁLISAN: a feladat a VS Code-ban vagy a MongoDB Shell-ben is megoldható

1. A MongoDB Compass-ban készítsen új indexet a 7. feladatban importált receptek gyűjteményhez az Indexes rész Create Index funkciójának segítségével!


a. Az index neve legyen i_title, és a title mező szerint csökkenő legyen
b. Az index  egyedi (unique) legyen (Options rész)!

OPCIONÁLISAN: a feladat a VS Code-ban vagy a MongoDB Shell-ben is megoldható

10. A MongoDB Compass-ban nyissunk egy parancssort (MongoDB shell)!
a. Adjuk ki a show dbs parancsot!
b. Csatlakozzunk a gyak_compass adatbázishoz!

```js
show dbs
use gyak_compass
```

11. A mongo shellben kérdezzük le, hogy a receptek gyűjteményben mely dokumentumoknál szerepel a recept nevében (title) a Tacos szó!

a. A megjelenés kellően szép (json-szerű) legyen!


```js
use gyak_compass

db.receptek.find(
  { title: /Tacos/ }
).pretty()

```
OPCIONÁLISAN: a feladat a MongoDB Compass-ban, vagy a VS Code-ban is megoldható

12. A mongo shell-ben kérdezzük le, hogy recept  típusonként (type) mennyi a főzési idők (cook_time) összege!

```js
db.receptek.aggregate([
  {
    $group: {
      _id: "$type",
      totalCookTime: { $sum: "$cook_time" }
    }
  }
]).pretty()

```
OPCIONÁLISAN: a feladat a MongoDB Compass-ban, vagy a VS Code-ban is megoldható


13. A mongo shell-ben kérdezzük le, hogy a receptek gyűjteményben hány olyan dokumentum van, ahol:

a. A recept 4 főre szól (servings) ÉS
b. A tag-ek között szerepel a "quick" vagy az "easy" (legalább az egyik)


```js
db.receptek.find({
  servings: 4,
  tags: { $in: ["quick", "easy"] }
}).count()
```

OPCIONÁLISAN: a feladat a MongoDB Compass-ban, vagy a VS Code-ban is megoldható

14. A mongo shell-ben a receptek gyűjteményben a ObjectId("5e878f5220a4f574c0aa56db") azonosítójú dokumentum esetén módosítsuk a főzési időt (cook_time) 33 percre!

```js
db.receptek.updateOne(
  { _id: ObjectId("5e878f5220a4f574c0aa56db") },
  { $set: { cook_time: 33 } }
)
```

OPCIONÁLISAN: a feladat a MongoDB Compass-ban, vagy a VS Code-ban is megoldható

15. A mongo shell-ben adjunk hozzá a ObjectId("5e5e9c470d33e9e8e3891b35") azonosítójú dokumentum likes tömbjéhez még egy értéket, mégpedig a 200-at!


```js
db.receptek.updateOne(
  { _id: ObjectId("5e5e9c470d33e9e8e3891b35") },
  { $push: { likes: 200 } }
)
s
```

OPCIONÁLISAN: a feladat a MongoDB Compass-ban, vagy a VS Code-ban is megoldható
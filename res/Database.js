/****************************************************************************
**
** Copyright (C) 2018 Mihaly Borzsei
**
** ColorBoxes - Application Settings
*/


function init(model) {
    var db = LocalStorage.openDatabaseSync("ColorBoxes_DB", "1.0", "Settings", 1000000)
    try {
        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS ColorBoxes (color text)')
            //   tx.executeSql('DROP TABLE Settings');
            tx.executeSql('CREATE TABLE IF NOT EXISTS Settings (key text, value text)');

            var ri = tx.executeSql('SELECT * FROM Settings where key=="selectedindex"');
            if (ri.rows.length===0) // initial settings
            {
                tx.executeSql('INSERT OR REPLACE INTO Settings (key,value) VALUES("selectedindex","-1")');
                tx.executeSql('INSERT OR REPLACE INTO Settings (key,value) VALUES("selectedColor","mediumaquamarine")');
                tx.executeSql('INSERT OR REPLACE INTO Settings (key,value) VALUES("customColor","mediumaquamarine")');
            }

            var rs = tx.executeSql('SELECT * FROM ColorBoxes');
            model.clear();
            for (var i = 0; i < rs.rows.length; i++) {
                model.append({
                                 color: rs.rows.item(i).color
                             })

            }

        })
    } catch (err) {
        console.log("Error creating table in database: " + err)
    };
}

function dbGetHandle()
{
    try {
        var db = LocalStorage.openDatabaseSync("ColorBoxes_DB", "1.0", "Settings", 1000000)
    } catch (err) {
        console.log("Error opening database: " + err)
    }
    return db
}
function dbloadSettings()
{
    var db = dbGetHandle();
    try {
        db.transaction(function (tx) {
            var ri = tx.executeSql('SELECT * FROM Settings where key=="selectedindex"');
            //  console.log(parseInt(ri.rows.item(0).value));
            colorboxSettings.selectedIndex=parseInt(ri.rows.item(0).value); //
            var rj = tx.executeSql('SELECT * FROM Settings where key=="selectedColor"');
            colorboxSettings.selectedColor=rj.rows.item(0).value;
            screen2.selectedColor=colorboxSettings.selectedColor;
            var rk = tx.executeSql('SELECT * FROM Settings where key=="customColor"');
            colorboxSettings.customColor=rk.rows.item(0).value;
            screen2.customColor=colorboxSettings.customColor;
        })

    } catch (err) {
        console.log("Error creating table in database: " + err)
    };

}
function dbUpdateSelectedIndex(index)
{
    var db = dbGetHandle();
    db.transaction(function (tx) {
        tx.executeSql(
                    'update Settings set value=? where key="selectedindex"', [index.toString()])
    })
}

function dbUpdateSelectedColor(color)
{
    var db = dbGetHandle();
    db.transaction(function (tx) {
        tx.executeSql(
                    'update Settings set value=? where key="selectedColor"', [color])
    })
}

function dbUpdateCustomColor(color)
{
    var db = dbGetHandle();
    db.transaction(function (tx) {
        tx.executeSql(
                    'update Settings set value=? where key="customColor"', [color])
    })
}

function dbUpdateColorBoxes(model)
{
    var db = dbGetHandle();
    db.transaction(function (tx) {
        tx.executeSql('DELETE FROM ColorBoxes');
        for (var i = 0; i < model.count; i++) {
            console.log(model.get(i).color)
            tx.executeSql('INSERT OR REPLACE INTO ColorBoxes VALUES(?)',[model.get(i).color]);
        }
    })
}

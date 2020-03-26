const express = require("express");
const app = express();
const port = 3000;
const mysql = require("mysql");
const bodyParser = require("body-parser");

app.set("view engine", "pug");

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

var connection = mysql.createConnection({
  host: "127.0.0.1",
  user: "root",
  password: "password",
  database: "lab7"
});

connection.connect(function(err) {
  if (err) throw err;
  console.log("Connected!");
});

app.get("/", (req, res) => {
  if (req.query.id != null) {
    connection.query(
      "SELECT * FROM Student WHERE student_id LIKE '%" + req.query.id + "%'",
      (err, result) => {
        res.render("student/index", {
          student: result
        });
      }
    );
    console.log("Search!");
  } else {
    connection.query("SELECT * FROM Student", (err, result) => {
      res.render("student/index", {
        student: result
      });
    });
    console.log("Query!");
  }
});

app.get("/take", (req, res) => {
  if (req.query.id != null) {
    connection.query(
      "SELECT * FROM Takes WHERE student_id LIKE '%" + req.query.id + "%'",
      (err, result) => {
        res.render("take/index", {
          take: result
        });
      }
    );
    console.log("Search!");
  } else {
    connection.query("SELECT * FROM Takes", (err, result) => {
      res.render("take/index", {
        take: result
      });
    });
    console.log("Query!");
  }
});

app.post("/add", (req, res) => {
  const student_id = req.body.student_id;
  const name = req.body.name;
  const year = req.body.year;
  const email = req.body.email;
  const post = {
    student_id: student_id,
    name: name,
    year: year,
    email: email
  };
  connection.query("INSERT INTO Student SET ?", post, err => {
    console.log("Student Inserted");
    return res.redirect("/");
  });
});

app.get("/add", (req, res) => {
  res.render("student/add");
});

app.get("/take/add", (req, res) => {
  res.render("take/add");
});

app.post("/take/add", (req, res) => {
  const student_id = req.body.student_id;
  const cid = req.body.cid;
  const sect_id = req.body.sect_id;
  const semester = req.body.semester;
  const year = req.body.year;
  const grade = req.body.grade;
  const post = {
    student_id,
    cid,
    sect_id,
    semester,
    year,
    grade
  };
  connection.query("INSERT INTO Takes SET ?", post, err => {
    console.log("Enrollment Inserted");
    return res.redirect("/take");
  });
});

app.get("/edit/:id", (req, res) => {
  const edit_postID = req.params.id;

  connection.query(
    "SELECT * FROM Student WHERE student_id=?",
    [edit_postID],
    (err, results) => {
      if (results) {
        res.render("student/edit", {
          student: results[0]
        });
      }
    }
  );
});

app.get("/take/edit/:id", (req, res) => {
  const edit_postID = req.params.id;

  connection.query(
    "SELECT * FROM Takes WHERE student_id=?",
    [edit_postID],
    (err, results) => {
      if (results) {
        res.render("take/edit", {
          take: results[0]
        });
      }
    }
  );
});

app.post("/edit/:id", (req, res) => {
  const update_name = req.body.name;
  const update_year = req.body.year;
  const update_email = req.body.email;
  const userId = req.params.id;
  connection.query(
    "UPDATE `Student` SET name = ?, year = ?, email = ? WHERE student_id = ?",
    [update_name, update_year, update_email, userId],
    (err, results) => {
      if (results.changedRows === 1) {
        console.log("Student Updated");
      }
      return res.redirect("/");
    }
  );
});

app.post("/take/edit/:id", (req, res) => {
  const update_year = req.body.year;
  const update_grade = req.body.grade;
  const update_cid = req.body.cid;
  const update_sect_id = req.body.sect_id;
  const update_semester = req.body.semester;

  const userId = req.params.id;
  connection.query(
    "UPDATE `Takes` SET cid = ?, sect_id = ?, semester = ? ,year = ? ,grade = ? WHERE student_id = ?",
    [
      update_cid,
      update_sect_id,
      update_semester,
      update_year,
      update_grade,
      userId
    ],
    (err, results) => {
      if (results.changedRows === 1) {
        console.log("Enrollment Updated");
      }
      return res.redirect("/take");
    }
  );
});

app.get("/delete/:id", (req, res) => {
  connection.query(
    "DELETE FROM `Student` WHERE student_id = ?",
    [req.params.id],
    (err, results) => {
      return res.redirect("/");
    }
  );
});

app.get("/take/delete/:id", (req, res) => {
  connection.query(
    "DELETE FROM `Takes` WHERE student_id = ?",
    [req.params.id],
    (err, results) => {
      return res.redirect("/take");
    }
  );
});

app.listen(port, () => console.log(`Example app listening on port ${port}!`));

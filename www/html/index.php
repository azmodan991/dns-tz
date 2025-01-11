<?php
// данные для подключения к бд
$host = 'localhost'; 								// бд развернута локально
$dbname = 'test_db'; 								// название бд, к которой подлючаемся
$user = 'db_user';								// имя пользака для коннекта
$password = 'db_password';							// его пароль 

// само подключение
try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);	// cоздание нового подключения к бд с использованием PDO (для себя провел аналогию с экзепляром или же объектом класса, с которым дальше и работаем)
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);		// обработки ошибок PDO для того, чтобы при ошибках выбрасывались исключения, которые можно отлавливать

    // по своей сути тело запроса
    $stmt = $pdo->query("SELECT * FROM test_table LIMIT 2");			// сам запрос
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);					// извлекаем строки из заброса (как я понял, возвращает массив)

    // вывод
    echo "<h1>Data from MySQL:</h1>";						// чтобы красиво
    echo "<ul>";								// начинаем спиоск, чтобы потом по строчечкам выводить
    foreach ($rows as $row) {							// проход по каждой строке (ну или уже можно сказать по элементу массива)
        echo "<li>" . htmlspecialchars($row['column_name']) . "</li>";		// вывод элемента
    }
    echo "</ul>";								// собсна заканчиваем массив
} catch (PDOException $e) {
    echo "Connection failed: " . $e->getMessage();				// стандартный обработчик ошибок, чтобы если коннекта не было, то выводился месейдж
}
?>

# Tic Tac Toe Application

## วิธีการติดตั้งและรันโปรแกรม

### ขั้นตอนการติดตั้ง

1. **ติดตั้ง Flutter SDK**:
    ดาวน์โหลดและติดตั้ง [Flutter SDK](https://flutter.dev/docs/get-started/install) หากยังไม่ได้ติดตั้ง

2. **โคลนโปรเจกต์นี้**:
    ```bash
    https://github.com/magrolix4k/TIC_TAC_TOE_Application
    ```

### ขั้นตอนการรันโปรแกรม

1. **เข้าไปยังไดเรกทอรีของโปรเจกต์**:
    ```bash
    cd tic_tac_toe_game
    ```

2. **ติดตั้ง Dependencies**:
    รันคำสั่งต่อไปนี้เพื่อทำการติดตั้ง dependencies ที่จำเป็นสำหรับโปรเจค:
    ```bash
    flutter pub get
    ```
3. **รันแอปพลิเคชันบน Emulator หรือ Device จริง**:
    ```bash
    flutter run
    ```

## การออกแบบโปรแกรมและ Algorithm ที่ใช้

### การออกแบบโปรแกรมและโครงสร้างไฟล์ของโปรเจค

  * lib/
    * core/
    * data/
    * domain/
    * presentation/
    * main.dart

### Core
  ประกอบด้วย enums, constants และฟังก์ชันหลักต่าง ๆ ที่ใช้ในแอปพลิเคชัน

### Data
  จัดการเกี่ยวกับข้อมูล รวมถึงการสื่อสารกับฐานข้อมูลในเครื่องและโมเดลข้อมูล

### Domain
  ประกอบด้วยลอจิกต่าง ๆ รวมถึง use cases

### Presentation
  จัดการกับส่วนประกอบ UI รวมถึงหน้าต่างๆ, widgets และการจัดการสถานะต่าง ๆ


## อัลกอริทึมหลัก

### ลอจิกเกม Tic Tac Toe
  ลอจิกเกมถูกใช้ในคลาส `TicTacToeBloc` ซึ่งจัดการสถานะเกม ตรวจสอบการชนะหรือเสมอ และจัดการการเดินของผู้เล่น

### AI ของบอท
  AI ของบอทถูกใช้โดยใช้อัลกอริทึม Minimax อัลกอริทึมนี้อยู่ใน `BotLogic`

1. **โหมดง่าย**: บอทเคลื่อนที่แบบสุ่ม
2. **โหมดปานกลาง**: บอทตรวจสอบการชนะทันทีหรือการบล็อก มิฉะนั้นจะเคลื่อนที่แบบสุ่ม
3. **โหมดยาก**: บอทใช้อัลกอริทึม Minimax เพื่อทำการเคลื่อนที่ที่ดีที่สุด

#### อัลกอริทึม Minimax
  อัลกอริทึม Minimax เป็นอัลกอริทึมแบบเรียกซ้ำสำหรับการเลือกการเคลื่อนที่ถัดไป โดยปกติเป็นเกมที่มีผู้เล่นสองคนและมีผลรวมเป็นศูนย์ ค่าจะถูกคำนวนกับแต่ละตำแหน่งหรือสถานะของเกม ค่านี้คำนวณโดยใช้ฟังก์ชันประเมินตำแหน่งและบ่งชี้ว่าการไปถึงตำแหน่งนั้นจะดีแค่ไหนสำหรับผู้เล่น จากนั้นผู้เล่นจะทำการเคลื่อนที่ที่เพิ่มค่าต่ำสุดของตำแหน่งที่เป็นผลมาจากการเคลื่อนที่ที่เป็นไปได้ของคู่ต่อสู้

#### Alpha-Beta Pruning
  Alpha-Beta pruning เป็นเทคนิคการเพิ่มประสิทธิภาพสำหรับอัลกอริทึม Minimax ช่วยลดเวลาในการคำนวณลงอย่างมากโดยการตัดกิ่งที่ไม่จำเป็นต้องค้นหาออกไป

### การดำเนินการกับฐานข้อมูล
  แอปพลิเคชันใช้ SQLite สำหรับการจัดเก็บประวัติเกมในเครื่อง คลาส `DatabaseHelper` จัดการกับการดำเนินการกับฐานข้อมูลทั้งหมด รวมถึงการสร้างตาราง การแทรกบันทึกเกม และการดึงประวัติเกม

## Algorithm ที่ใช้
  การทำการเคลื่อนไหวของผู้เล่น:
```dart
    void makeMove(int index) {
      if (board[index] == '') {
        board[index] = currentPlayer;
        moves.add({'player': currentPlayer, 'position': index});
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      }
    }
```
  การตรวจสอบผู้ชนะ:
```dart
bool checkWinner() {
  // Check rows
  for (int i = 0; i < boardSize; i++) {
    if (checkLine(i * boardSize, 1, boardSize)) return true;
  }

  // Check columns
  for (int i = 0; i < boardSize; i++) {
    if (checkLine(i, boardSize, boardSize)) return true;
  }

  // Check diagonals
  if (checkLine(0, boardSize + 1, boardSize)) return true;
  if (checkLine(boardSize - 1, boardSize - 1, boardSize)) return true;

  return false;
}

bool checkLine(int start, int step, int count) {
  final String first = board[start];
  if (first == '') return false;
  for (int i = 1; i < count; i++) {
    if (board[start + i * step] != first) return false;
  }
  return true;
}
```
  การบันทึกข้อมูลเกมลงฐานข้อมูล:
```dart
Future<void> saveGames(List<String> board, String currentPlayer,
    List<Map<String, dynamic>> moves, int boardSize) async {
  final db = await database;
  try {
    String gameData = jsonEncode({
      'board': board,
      'currentPlayer': currentPlayer,
      'moves': moves,
    });
    await db.insert('games', {
      'game_data': gameData,
      'timestamp': DateTime.now().toIso8601String(),
      'board_size': boardSize,
    });
    print('Saving game data: $gameData at ${DateTime.now().toIso8601String()}, Board size: $boardSize');
  } catch (e) {
    print('Error saving game: $e');
  }
}
```
  การดึงข้อมูลประวัติการเล่นเกม:
```dart
Future<List<Map<String, dynamic>>> getGameHistory() async {
  final db = await database;
  try {
    return await db.query('games', orderBy: 'timestamp DESC');
  } catch (e) {
    print('Error retrieving game history: $e');
    return [];
  }
}
```

## การใช้งาน
* เปิดแอปพลิเคชันเพื่อเริ่มต้นเกมใหม่ โดยสามารถเลือกขนาดของบอร์ดได้ตั้งแต่ 3x3 ถึง 10x10
* เล่นเกมบนหน้าจอ GameBoard โดยการแตะที่ตำแหน่งที่ต้องการทำการเคลื่อนไหว
* เมื่อเกมจบลง จะแสดงผลผู้ชนะหรือผลเสมอ และบันทึกข้อมูลเกมลงในฐานข้อมูล
* สามารถดูประวัติการเล่นเกมที่ผ่านมาได้จากหน้าจอ HistoryView
* สามารถเล่นซ้ำเกมที่บันทึกไว้ได้จากหน้าจอ ReplayView

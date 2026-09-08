import '../models/lesson.dart';

class ProgrammingData {
  static const fundamentals = [
    ProgrammingTopic(
      title: 'वेरिएबल्स (Variables)',
      language: 'Concept',
      description: 'Variables are like boxes that store information. एक बॉक्स की तरह जिसमें हम चीज़ें रखते हैं!',
      code: 'name = "Akshar"\nage = 10',
      explanation: 'हमने दो डिब्बे बनाए: एक में "Akshar" नाम संजोया, दूसरे में नंबर 10। अब ये कभी भी इस्तेमाल हो सकते हैं।',
    ),
    ProgrammingTopic(
      title: 'लूप्स (Loops)',
      language: 'Concept',
      description: 'Loops repeat an action many times. दोहराव - बार-बार वही काम करना!',
      code: 'for i in range(5):\n  print("Hello!")',
      explanation: 'यह कोड "Hello!" पाँच बार छापेगा। जैसे पहाड़े दोहराए जाते हैं, वैसे ही लूप काम करता है।',
    ),
    ProgrammingTopic(
      title: 'कंडीशन्स (Conditions)',
      language: 'Concept',
      description: 'Conditions help computers make decisions. फैसले लेना सिखाता है!',
      code: 'if marks >= 80:\n  print("Excellent!")\nelse:\n  print("Try harder!")',
      explanation: 'अगर अंक 80 या ज़्यादा हैं तो "Excellent!" प्रिंट होगा, वरना "Try harder!"। यह फैसला लेने जैसा है!',
    ),
  ];

  static const pythonTopics = [
    ProgrammingTopic(
      title: 'Python: Hello World',
      language: 'Python',
      description: 'Your first program! आपका पहला प्रोग्राम।',
      code: 'print("Hello, World!")',
      explanation: 'print() स्क्रीन पर कुछ दिखाने का मंत्र है। "Hello, World!" लिखने पर यही स्क्रीन पर आएगा!',
    ),
    ProgrammingTopic(
      title: 'Python: Simple Math',
      language: 'Python',
      description: 'Computers are great at math! कंप्यूटर गणित में आगे हैं।',
      code: 'print(5 + 3)\nprint(10 - 4)\nprint(6 * 7)',
      explanation: '+(जोड़), -(घटाव), *(गुणा) - कंप्यूटर पलक झपकते में जवाब देता है!',
    ),
    ProgrammingTopic(
      title: 'Python: Variables',
      language: 'Python',
      description: 'Storing and using values. मूल्यों को संजोना।',
      code: 'name = "Akshar"\nmarks = 95\nprint(name, marks)',
      explanation: 'name और marks दो डिब्बे हैं। उनमें मूल्य रखकर हम बाद में print से निकालते हैं।',
    ),
    ProgrammingTopic(
      title: 'Python: For Loop',
      language: 'Python',
      description: 'Repeat things automatically. स्वचालित दोहराव।',
      code: 'for i in range(1, 6):\n  print(i, "Akshar")',
      explanation: 'यह 1 से 5 तक प्रत्येक नंबर के साथ "Akshar" छापेगा। लूप हमें बचाता है दोहराव से।',
    ),
    ProgrammingTopic(
      title: 'Python: If Condition',
      language: 'Python',
      description: 'Making decisions in code. कोड में निर्णय लेना।',
      code: 'age = 10\nif age >= 10:\n  print("You can code!")\nelse:\n  print("Wait a bit!")',
      explanation: 'अगर age 10 या अधिक है तो पहला वरना दूसरा मैसेज दिखेगा। यही कंडीशन है!',
    ),
    ProgrammingTopic(
      title: 'Python: List & Loop',
      language: 'Python',
      description: 'Working with many values. कई मूल्यों के साथ काम।',
      code: 'fruits = ["Apple", "Mango", "Banana"]\nfor fruit in fruits:\n  print(fruit)',
      explanation: 'fruits एक सूची है जिसमें तीन फल हैं। लूप हर फल को एक-एक करके छापता है।',
    ),
  ];

  static const javaTopics = [
    ProgrammingTopic(
      title: 'Java: Hello World',
      language: 'Java',
      description: 'Java शुरुआती प्रोग्राम।',
      code: 'public class Main {\n  public static void main(String[] args) {\n    System.out.println("Hello, World!");\n  }\n}',
      explanation: 'Java में हर काम class के अंदर होता है। System.out.println स्क्रीन पर छापता है।',
    ),
    ProgrammingTopic(
      title: 'Java: Variables',
      language: 'Java',
      description: 'Types matter in Java. Java में प्रकार महत्वपूर्ण।',
      code: 'int age = 10;\ndouble price = 25.50;\nString name = "Akshar";\nSystem.out.println(name);',
      explanation: 'int नंबर, double दशमलव, String शब्द। प्रत्येक डिब्बे का अपना प्रकार है।',
    ),
    ProgrammingTopic(
      title: 'Java: If Else',
      language: 'Java',
      description: 'Conditions in Java. Java में कंडीशन्स।',
      code: 'int score = 85;\nif (score >= 80) {\n  System.out.println("A Grade!");\n} else {\n  System.out.println("Good Try!");\n}',
      explanation: '>= 80 पर A ग्रेड वरना Good Try। Java में if...else यही काम करता है।',
    ),
    ProgrammingTopic(
      title: 'Java: For Loop',
      language: 'Java',
      description: 'Loops in Java. Java में लूप्स।',
      code: 'for (int i = 1; i <= 5; i++) {\n  System.out.println("Count: " + i);\n}',
      explanation: 'यह लूप 1 से 5 तक Count: छापेगा। i++ का मतलब i को 1 बढ़ाना है।',
    ),
    ProgrammingTopic(
      title: 'Java: Magic Method',
      language: 'Java',
      description: 'Creating your own method. अपना फंक्शन बनाना।',
      code: 'public class Main {\n  static void greet(String n) {\n    System.out.println("Hello " + n);\n  }\n  public static void main(String[] args) {\n    greet("Akshar");\n  }\n}',
      explanation: 'greet() एक मंत्र है जो "Hello" + नाम छापता है। इसे बार-बार बुला सकते हैं।',
    ),
    ProgrammingTopic(
      title: 'Java: Arrays',
      language: 'Java',
      description: 'Lists of values. मूल्यों की सूची।',
      code: 'int[] marks = {90, 80, 70};\nfor (int m : marks) {\n  System.out.println(m);\n}',
      explanation: 'marks में तीन अंक हैं। प्रत्येक को एक-एक करके छापते हैं।',
    ),
  ];

  static const cTopics = [
    ProgrammingTopic(
      title: 'C: Hello World',
      language: 'C',
      description: 'दुनिया की जड़ भाषा।',
      code: '#include <stdio.h>\nint main() {\n  printf("Hello, World!\\n");\n  return 0;\n}',
      explanation: 'stdio.h इनपुट-आउटपुट का साथी है। printf छापने का मंत्र है, return 0 Matlab sahi chal raha hai.',
    ),
    ProgrammingTopic(
      title: 'C: Variables',
      language: 'C',
      description: 'Basic data in C.',
      code: 'int age = 10;\nfloat pi = 3.14;\nchar grade = \'A\';\nprintf("%d %f %c", age, pi, grade);',
      explanation: 'int नंबर, float दशमलव, char अकेला अक्षर। %d, %f, %c प्रिंट के निशान हैं।',
    ),
    ProgrammingTopic(
      title: 'C: For Loop',
      language: 'C',
      description: 'Counting in C.',
      code: 'for (int i = 1; i <= 5; i++) {\n  printf("%d ", i);\n}',
      explanation: 'C का लूप जावा जैसा ही है। 1 से 5 तक नंबर छपेंगे।',
    ),
    ProgrammingTopic(
      title: 'C: If Condition',
      language: 'C',
      description: 'Control flow in C.',
      code: 'int marks = 95;\nif (marks > 90) {\n  printf("Outstanding!");\n} else {\n  printf("Great!");\n}',
      explanation: '90 से ऊपर Outstanding, वरना Great। C में यह निर्णय लेता है।',
    ),
  ];

  static const cppTopics = [
    ProgrammingTopic(
      title: 'C++: Hello World',
      language: 'C++',
      description: 'C++ की शुरुआत।',
      code: '#include <iostream>\nusing namespace std;\nint main() {\n  cout << "Hello, World!" << endl;\n  return 0;\n}',
      explanation: 'iostream इनपुट-आउटपुट है, cout छापता है, endl नई पंक्ति बनाता है।',
    ),
    ProgrammingTopic(
      title: 'C++: Variables & Types',
      language: 'C++',
      description: 'Modern C++ data.',
      code: 'string name = "Akshar";\nint age = 10;\ncout << name << " is " << age << " years old";',
      explanation: 'string शब्दों के लिए, int नंबरों के लिए। C++ में << छापने का तीर है।',
    ),
    ProgrammingTopic(
      title: 'C++: Loop',
      language: 'C++',
      description: 'Repetition in C++.',
      code: 'for (int i = 0; i < 3; i++) {\n  cout << "Fun! " << i << endl;\n}',
      explanation: 'यह "Fun!" तीन बार छापेगा। i++ हर बार 1 जोड़ता है।',
    ),
    ProgrammingTopic(
      title: 'C++: Condition & Functions',
      language: 'C++',
      description: 'Functions in C++.',
      code: 'int add(int a, int b) {\n  return a + b;\n}\nint main() {\n  cout << add(5, 3);\n  return 0;\n}',
      explanation: 'add() दो नंबर लेता है और उनका जोड़ लौटाता है। फंक्शन कोड को छोटा और साफ़ रखते हैं।',
    ),
  ];
}
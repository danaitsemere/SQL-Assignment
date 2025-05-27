
fun main() {
    val courses = listOf(
        Course("A", 3),
        Course("B+", 4),
        Course("C", 3),
        Course("F", 2)
    )

    val student1 = Student("Eyeru")
    student1.recordGrade(85.0)
    student1.recordGrade(92.0)
    println(student1.calculateGradePoints(76.21))
    println("${student1.name}'s grades: ${student1.getGrades()}")
    val gpa = calculateGPA(courses)
    println("Your GPA is: $gpa")

//    var mathGrade = Grade("Maths", 95.0)
//    var physicsGrade = Grade("English", 88.5)

}

val gradePoints = mapOf(
    "A+" to 4.0, "A" to 4.0, "A-" to 3.7,
    "B+" to 3.3, "B" to 3.0, "B-" to 2.7,
    "C+" to 2.3, "C" to 2.0, "C-" to 1.7,
    "D+" to 1.3, "D" to 1.0, "D-" to 0.7,
    "F" to 0.0
)
data class Course(val grade: String, val credits: Int)
//data class Grade(val course: String, val grade: Double)
fun calculateGPA(courses: List<Course>): Double {
    var totalGradePoints = 0.0
    var totalCredits = 0

    for (course in courses) {
        val gradePoint = gradePoints[course.grade.uppercase()] ?: 0.0
        totalGradePoints += gradePoint * course.credits
        totalCredits += course.credits
    }

    return if (totalCredits > 0) totalGradePoints / totalCredits else 0.0
}
class Student(val name: String) {
    private val grades = mutableListOf<Double>()

    fun recordGrade(grade: Double) {
        grades.add(grade)
    }

    fun getGrades(): List<Double> {
        return grades.toList()
    }
    fun calculateGradePoints(grade: Double): Double {
        return when {
            grade >= 90 -> 4.0
            grade >= 80 -> 3.0
            grade >= 70 -> 2.0
            grade >= 60 -> 1.0
            else -> 0.0
        }
    }
}

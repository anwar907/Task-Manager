extension DateTimeExtensions on DateTime {
  /// Formats DateTime to dd-MM-yyyy string
  String toDisplayFormat() {
    return '$day-$month-$year';
  }

  /// Formats DateTime to yyyy-MM-dd string (PostgreSQL format)
  String toDbFormat() {
    final dayStr = day.toString().padLeft(2, '0');
    final monthStr = month.toString().padLeft(2, '0');
    return '$year-$monthStr-$dayStr';
  }

  /// Gets task status based on date and completion
  String getTaskStatus(bool isCompleted) {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final thisDate = DateTime(year, month, day);

    if (thisDate.isBefore(todayDate) && isCompleted) {
      return 'Done';
    } else if (thisDate.isAtSameMomentAs(todayDate)) {
      return 'In Progress';
    } else {
      return 'To do';
    }
  }
}

extension StringDateExtensions on String {
  /// Parses date string (supports both dd-MM-yyyy and yyyy-MM-dd)
  DateTime? toDateTime() {
    try {
      final parts = split('-');
      if (parts.length == 3) {
        int day, month, year;

        // Check if it's yyyy-MM-dd format (year > 31)
        if (int.parse(parts[0]) > 31) {
          year = int.parse(parts[0]);
          month = int.parse(parts[1]);
          day = int.parse(parts[2]);
        } else {
          // dd-MM-yyyy format
          day = int.parse(parts[0]);
          month = int.parse(parts[1]);
          year = int.parse(parts[2]);
        }

        // Validate ranges
        if (day < 1 || day > 31 || month < 1 || month > 12 || year < 1900) {
          return null;
        }

        return DateTime(year, month, day);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Converts dd-MM-yyyy to yyyy-MM-dd format
  String toDbFormat() {
    try {
      final parts = split('-');
      if (parts.length == 3) {
        final day = parts[0].padLeft(2, '0');
        final month = parts[1].padLeft(2, '0');
        final year = parts[2];
        return '$year-$month-$day';
      }
      return this;
    } catch (e) {
      return this;
    }
  }

  /// Gets task status from date string
  String getTaskStatus(bool isCompleted) {
    final dateTime = toDateTime();
    if (dateTime != null) {
      return dateTime.getTaskStatus(isCompleted);
    }
    return isCompleted ? 'Done' : 'Pending';
  }
}

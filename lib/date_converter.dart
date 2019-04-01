int div(int a, int b) {
  return (a / b).toInt();
}

List<int> gregorianToJalali(int g_y, int g_m, int g_d) {

  var gDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  var jDaysInMonth = [31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29];
  int gy = g_y - 1600;
  int gm = g_m - 1;
  int gDayNo =
      (365 * gy + div(gy + 3, 4) - div(gy + 99, 100) + div(gy + 399, 400));

  for (int i = 0; i < gm; ++i) {
    gDayNo += gDaysInMonth[i];
  }

  if (gm > 1 && ((gy % 4 == 0 && gy % 100 != 0) || (gy % 400 == 0))) {
    // leap and after Feb
    gDayNo++;
  }
  gDayNo += g_d - 1;
  int jDayNo = gDayNo - 79;
  int jNp = div(jDayNo, 12053); // 12053 = (365 * 33 + 32 / 4)
  jDayNo = jDayNo % 12053;
  int jy = (979 + 33 * jNp + 4 * div(jDayNo, 1461)); // 1461 = (365 * 4 + 4 / 4)
  jDayNo %= 1461;

  if (jDayNo >= 366) {
    jy += div(jDayNo - 1, 365);
    jDayNo = (jDayNo - 1) % 365;
  }
  int i = 0;
  for (; (i < 11 && jDayNo >= jDaysInMonth[i]); ++i) {
    jDayNo -= jDaysInMonth[i];
  }

  return [jy, i + 1, jDayNo + 1];
}

List<int> jalaliToGregorian(int jY, int jM, int jD, bool str) {
  var gDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  var jDaysInMonth = [31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29];

  int jy = jY - 979;
  int jm = jM - 1;
  int jd = jD - 1;

  int jDayNo = 365 * jy + div(jy, 33) * 8 + div(jy % 33 + 3, 4);

  for (int i = 0; i < jm; ++i) jDayNo += jDaysInMonth[i];

  jDayNo += jd;

  int gDayNo = jDayNo + 79;

  int gy = 1600 +
      400 *
          div(gDayNo,
              146097); /* 146097 = 365*400 + 400/4 - 400/100 + 400/400 */
  gDayNo = gDayNo % 146097;

  bool leap = true;
  if (gDayNo >= 36525) /* 36525 = 365*100 + 100/4 */ {
    gDayNo--;
    gy += 100 * div(gDayNo, 36524); /* 36524 = 365*100 + 100/4 - 100/100 */
    gDayNo = gDayNo % 36524;

    if (gDayNo >= 365)
      gDayNo++;
    else
      leap = false;
  }

  gy += 4 * div(gDayNo, 1461); /* 1461 = 365*4 + 4/4 */
  gDayNo %= 1461;

  if (gDayNo >= 366) {
    leap = false;

    gDayNo--;
    gy += div(gDayNo, 365);
    gDayNo = gDayNo % 365;
  }

  int gm;
  int gd;

  getDayInMounth(int month){
    if(month == 1 && leap){
      return gDaysInMonth[month] +1;
    }

    return gDaysInMonth[month] ;
  }

  int i;

  for (i = 0; gDayNo >= getDayInMounth(i); i++) {
    gDayNo -= getDayInMounth(i);
  }

  gm = i + 1;
  gd = gDayNo + 1;

//  if(str) return '$gy/$gm/$gd';
  return [gy, gm, gd];
}

String getPersianDate(DateTime a) {
  var j = gregorianToJalali(a.year, a.month, a.day);
  return j.join("-");
}

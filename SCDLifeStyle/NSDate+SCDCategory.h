
#import <Foundation/Foundation.h>


struct SCDDateInformation {
	int day;
	int month;
	int year;
	
	int weekday;
	
	int minute;
	int hour;
	int second;
	
};
typedef struct SCDDateInformation SCDDateInformation;

/** Additional functionality for `NSDate`. */
@interface NSDate (SCDCategory)

+ (NSDate *) yesterday;


/** Creates and returns a new date set to the current month.
 @return A `NSDate` object set to the current month.
 */
+ (NSDate *) month;

/** Creates and returns a new date set to the first day of the month from the date object.
 @return A `NSDate` object set to the same month as the date object. The day will be the first of the month.
 */
- (NSDate *) monthDate;



- (BOOL) isSameDay:(NSDate*)anotherDate;
- (int) monthsBetweenDate:(NSDate *)toDate;
- (NSInteger) daysBetweenDate:(NSDate*)date;

/** Returns a Boolean value that indicates whether the date object is that same date information as the current day. 
 @return YES if the date object represents the current date, otherwise NO.
 */
- (BOOL) isToday;

- (BOOL) isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate;

- (NSDate *) dateByAddingDays:(NSUInteger)days;
+ (NSDate *) dateWithDatePart:(NSDate *)aDate andTimePart:(NSDate *)aTime;

- (NSString *) monthString;
- (NSString *) yearString;


- (SCDDateInformation) dateInformation;
- (SCDDateInformation) dateInformationWithTimeZone:(NSTimeZone*)tz;
+ (NSDate*) dateFromDateInformation:(SCDDateInformation)info;
+ (NSDate*) dateFromDateInformation:(SCDDateInformation)info timeZone:(NSTimeZone*)tz;
+ (NSString*) dateInformationDescriptionWithInformation:(SCDDateInformation)info;

@end

///////////////////////////////////////////////////////////////////////////////////
//
// CPE2073
// Yasir Choudhury - orb234
//

// Depending on your compiler settings, you may need to comment out
// system() call or the printf() call, below.
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <math.h>

#ifdef _WIN32
#include <process.h>
#define keypress() system("pause")
#else
#define keypress() //printf( "Press [Enter] to continue . . .\n"); getchar()
#endif

// Calculate the mean (average) of a set of data
double mean(double data[], int count){

	double sum = 0; // initialize local variables sum and average for this function
	double average = 0;
	for(int i = 0; i < count; i++){
		sum += data[i];
	}
	average = sum/count;
	return average;
}

// Calculate the standard deviation of a set of data
double stdDev(double data[], int count){

	double sum = 0; // initialize local variables sum and average for this function
	double average = 0;
	double square = 0; // used as a stepping stone to get standardDev, because standardDev is a square root.
	double standardDev = 0;
	for(int i = 0; i < count; i++){
		sum += data[i];
	}
	average = sum/count;

	for(int i = 0; i < count; i++){
		square += (((data[i] - average)*(data[i] - average))/count);
		standardDev = sqrt(square); // take square root of final value
	}

	return standardDev;

}

int readData(double data[], int maxSize){
	// Open the file for reading
	FILE* gradesFile = fopen("grades", "rt");
	if (!gradesFile)
	{
		printf("Unable to open file.");
		keypress();
		return 1;
	}

	// Keep track of how many items (grades) were read from the file
	int count = 0;
	while (!feof(gradesFile) && count < maxSize){ // don't let array overflow

		fscanf(gradesFile, "%lf", &data[count++]);
	}

	// Close the file
	fclose(gradesFile);

	// Return the number of items read from the file
	return count;
}

int main()
{
	// Declare an array to hold the data. 100 is the maximum items
	// we can store, but we may get less than that.

	double data[100] = { 0 }; // this will initialize all values to 0

	// Need to keep track of how many items we actually have (must be less than 100).
	int count = readData(data, 100);

	double avg = mean(data, count);
	double std = stdDev(data, count);

	printf("Read %i grades. The mean is %.1lf and the std deviation is %.1lf\n",
		count, avg, std);

	keypress();
	return 0;
}

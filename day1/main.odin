package day1
import "core:fmt"
import "core:os"
import "core:strings"
import "core:time"

part1 :: proc() {
	text, _ := os.read_entire_file_from_filename("input.txt", context.temp_allocator)
	text_ := strings.split_lines(cast(string)text, context.temp_allocator)
	sum := 0
	for t in text_ {
		first_digit := t[strings.index_any(t, "0123456789")] - 48
		second_digit := t[strings.last_index_any(t, "0123456789")] - 48
		sum += (cast(int)first_digit * 10) + cast(int)second_digit
	}

	fmt.println("the sum is:", sum)
}

part2 :: proc() {
	spelled_digits := [?]string {
		"one",
		"two",
		"three",
		"four",
		"five",
		"six",
		"seven",
		"eight",
		"nine",
	}
	text, _ := os.read_entire_file_from_filename("input.txt", context.temp_allocator)
	text_ := strings.split_lines(cast(string)text, context.temp_allocator)

	start := time.tick_now()
	sum := 0
	for t in text_ {
		first_digit := -1
		last_digit := -1

		for letter, index in t {
			result := -1
			if letter >= '0' && letter <= '9' {
				result = cast(int)letter - 48
			}
			if result == -1 {
				word := t[index:]
				for digit, index in spelled_digits {
					digit_length := len(digit)
					if len(word) >= digit_length && word[:digit_length] == digit {
						result = index + 1
						break
					}
				}
			}

			if result != -1 {
				if first_digit == -1 {
					first_digit = result
				}
				last_digit = result
			}
		}

		sum += (first_digit * 10) + last_digit
	}

	fmt.println("time:", time.tick_since(start))
	fmt.println("the sum is:", sum)
}

main :: proc() {
	// part1()
	part2()
}

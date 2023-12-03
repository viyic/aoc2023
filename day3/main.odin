package day3
import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"

part1 :: proc() {
	text_byte, _ := os.read_entire_file_from_filename("input.txt")
	text := cast(string)text_byte
	lines := strings.split_lines(text)
	sum := 0
	for line, line_index in lines {
		if line_index == 0 do fmt.println(line)
		line_length := len(line)
		cursor := 0
		for {
			for cursor < line_length && (line[cursor] < '0' || line[cursor] > '9') do cursor += 1
			end_cursor := cursor
			for end_cursor < line_length && line[end_cursor] >= '0' && line[cursor] <= '9' do end_cursor += 1

			found_symbol := false
			start_x := max(0, cursor - 1)
			end_x := min(line_length - 1, end_cursor)
			start_y := max(0, line_index - 1)
			end_y := min(len(lines) - 1, line_index + 1)
			search: for line_y := start_y; line_y <= end_y; line_y += 1 {
				for line_x := start_x; line_x <= end_x; line_x += 1 {
					if line_index == 0 do fmt.println("line_y", line_y, "line_x", line_x, cast(rune)lines[line_y][line_x])
					symbol := lines[line_y][line_x]
					if symbol != '.' && (symbol < '0' || symbol > '9') {
						found_symbol = true
						break search
					}
				}
			}
			if line_index == 0 do fmt.println("search", found_symbol)

			if found_symbol {
				sum += strconv.atoi(line[cursor:end_cursor])
			}

			cursor = end_cursor + 1
			if cursor >= line_length do break
		}
	}

	fmt.println(sum)
}

part2 :: proc() {
	text_byte, _ := os.read_entire_file_from_filename("input.txt")
	text := cast(string)text_byte

	sum := 0
	lines := strings.split_lines(text)
	for line, line_index in lines {
		line_length := len(line)

		cursor := 0
		for cursor < line_length {
			for cursor < line_length && line[cursor] != '*' do cursor += 1
			if cursor == line_length do break
			// fmt.println("found", line_index, cast(rune)line[cursor])

			found_numbers: [dynamic][]int
			start_x := max(0, cursor - 1)
			end_x := min(line_length - 1, cursor + 1)
			start_y := max(0, line_index - 1)
			end_y := min(len(lines) - 1, line_index + 1)
			search: for line_y := start_y; line_y <= end_y; line_y += 1 {
				for line_x := start_x; line_x <= end_x; line_x += 1 {
					number := lines[line_y][line_x]
					if number >= '0' && number <= '9' {
						arr := make([]int, 2)
						arr[0] = line_y
						arr[1] = line_x
						append(&found_numbers, arr)
						for line_x < len(lines[line_y]) && lines[line_y][line_x] >= '0' && lines[line_y][line_x] <= '9' do line_x += 1
					}
				}
			}
			if line_index == 1 do fmt.println("search", found_numbers)

			if len(found_numbers) == 2 {
				multiply := 1
				for number in found_numbers {
					cursor_y := number[0]
					line := lines[cursor_y]
					line_length := len(line)
					cursor_start_x := number[1]
					for cursor_start_x - 1 >= 0 && line[cursor_start_x - 1] >= '0' && line[cursor_start_x - 1] <= '9' do cursor_start_x -= 1
					cursor_end_x := number[1]
					for cursor_end_x < line_length && line[cursor_end_x] >= '0' && line[cursor_end_x] <= '9' do cursor_end_x += 1
					if line_index == 1 do fmt.println("search", line[cursor_start_x:cursor_end_x])

					multiply *= strconv.atoi(line[cursor_start_x:cursor_end_x])
				}
				sum += multiply
			}

			cursor += 1
		}
	}

	fmt.println(sum)
}

main :: proc() {
	// part1()
	part2()
}

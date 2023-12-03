package day2
import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"

// @note: for this day i try a different way to parse the input just for the fun of it
// definitely a lot messier and easier to mess up, but whatever lol

COLORS :: [?]string{"red", "green", "blue"}

part1 :: proc() {
	text, _ := os.read_entire_file_from_filename("input.txt")

	sum_of_valid_ids := 0

	cursor := 0
	for {
		valid := true
		bag := [3]int{}

		game := cast(string)text[cursor:][:5]
		cursor += 5 // skip "Game "
		end_cursor := cursor

		for text[end_cursor] != ':' do end_cursor += 1
		id := cast(string)text[cursor:end_cursor]

		cursor = end_cursor
		for cursor < len(text) && text[cursor] != '\n' {
			cursor += 2 // skip ": ", ", ", "; "
			end_cursor = cursor
			for text[end_cursor] >= '0' && text[end_cursor] <= '9' do end_cursor += 1
			amount := strconv.atoi(cast(string)text[cursor:end_cursor])

			cursor = end_cursor + 1 // skip " "
			end_cursor = cursor
			for end_cursor < len(text) && text[end_cursor] != '\n' && text[end_cursor] != ',' && text[end_cursor] != ';' do end_cursor += 1
			for color, index in COLORS {
				if cast(string)text[cursor:end_cursor] == color {
					bag[index] += amount
					break
				}
			}

			cursor = end_cursor
			if cursor >= len(text) || text[cursor] == '\n' || text[cursor] == ';' {
				if bag[0] > 12 || bag[1] > 13 || bag[2] > 14 {
					valid = false
				}
				bag = {}
			}
		}

		if valid {
			sum_of_valid_ids += strconv.atoi(id)
			fmt.println("id:", id)
		} else {
			fmt.println("-----id:", id, bag)
		}

		cursor += 1

		if cursor > len(text) do break
	}

	fmt.println("result:", sum_of_valid_ids)
}

part2 :: proc() {
	text, _ := os.read_entire_file_from_filename("input.txt")

	sum := 0

	cursor := 0
	for {
		valid := true
		min_bag := [3]int{}
		bag := [3]int{}

		game := cast(string)text[cursor:][:5]
		cursor += 5 // skip "Game "
		end_cursor := cursor

		for text[end_cursor] != ':' do end_cursor += 1
		id := cast(string)text[cursor:end_cursor]

		cursor = end_cursor
		for cursor < len(text) && text[cursor] != '\n' {
			cursor += 2 // skip ": ", ", ", "; "
			end_cursor = cursor
			for text[end_cursor] >= '0' && text[end_cursor] <= '9' do end_cursor += 1
			amount := strconv.atoi(cast(string)text[cursor:end_cursor])

			cursor = end_cursor + 1 // skip " "
			end_cursor = cursor
			for end_cursor < len(text) && text[end_cursor] != '\n' && text[end_cursor] != ',' && text[end_cursor] != ';' do end_cursor += 1
			for color, index in COLORS {
				if cast(string)text[cursor:end_cursor] == color {
					bag[index] += amount
					break
				}
			}

			cursor = end_cursor
			if cursor >= len(text) || text[cursor] == '\n' || text[cursor] == ';' {
				if bag[0] > min_bag[0] do min_bag[0] = bag[0]
				if bag[1] > min_bag[1] do min_bag[1] = bag[1]
				if bag[2] > min_bag[2] do min_bag[2] = bag[2]
				bag = {}
			}
		}

		sum += min_bag[0] * min_bag[1] * min_bag[2]

		cursor += 1

		if cursor > len(text) do break
	}

	fmt.println("result:", sum)
}

main :: proc() {
	// part1()
	part2()
}

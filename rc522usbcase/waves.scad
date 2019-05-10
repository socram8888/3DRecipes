
module waves(count=3, thickness=3) {
	difference() {
		for (i = [1 : 2 : 2 * count]) {
			difference() {
				circle(thickness * (i + 1));
				circle(thickness * i);
			}
		}

		polygon([
			[0, 0],
			[3 * thickness * count, 3 * thickness * count],
			[-3 * thickness * count, 3 * thickness * count]
		]);

		polygon([
			[0, 0],
			[3 * thickness * count, -3 * thickness * count],
			[-3 * thickness * count, -3 * thickness * count]
		]);
	}
}

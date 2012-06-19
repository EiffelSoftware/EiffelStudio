import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.TreeMap;
import java.util.Locale;
import java.util.Map;
import java.util.Scanner;

public class LogParser {
	public static void main(String[] args) throws IOException {
		Locale.setDefault(Locale.US);
		Scanner in = new Scanner(new File("log_scoopquery.txt"));
		TreeMap<Integer, TreeMap<Integer, Double>> map = new TreeMap<Integer, TreeMap<Integer, Double>>();
		String s = in.nextLine();
		int x0 = -1;
		int y0 = -1;
		double sum = 0;
		double max = 0;
		int cnt = 0;
		while (s != null) {
			if (s.contains("time")) {
				s = s.split(" ")[2];
				double t = Double.parseDouble(s);
				sum += t;
				max = Math.max(max, t);
				cnt++;
			} else {
				if (cnt > 1) {
					if (!map.containsKey(x0)) {
						map.put(x0, new TreeMap<Integer, Double>());
					}
					double t = (sum - max) / (cnt - 1);
					map.get(x0).put(y0, t);
				}
				String[] str = s.split(" ");
				x0 = Integer.parseInt(str[0]);
				y0 = Integer.parseInt(str[1]);
				sum = 0;
				max = 0;
				cnt = 0;
			}
			if (!in.hasNext()) {
				break;
			}
			s = in.nextLine();
		}
		PrintWriter out = new PrintWriter("output.txt");

		for (int x : map.keySet()) {
			for (int y : map.get(x).keySet()) {
				out.print("\t" + y);
			}
			break;
		}
		out.println();
		for (int x : map.keySet()) {
			out.print(x);
			TreeMap<Integer, Double> map3 = map.get(x);
			for (int y : map3.keySet()) {
				out.printf("\t%.5f", map3.get(y));
			}
			out.println();
		}
		out.println();
		out.close();
	}
}

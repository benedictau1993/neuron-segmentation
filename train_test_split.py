import h5py
import argparse


def train_test_split(filepath, z, x, y):
    with h5py.File(filepath, 'a') as f:
        image = f['/volumes/raw']
        label = f['volumes/labels/neuron_ids']

        test_image = image[:z, :x, :y]
        test_label = label[:z, :x, :y]

        train_image = image[:z, x:, y:]
        train_label = label[:z, x:, y:]

        dest = [('volumes/train/image', train_image),
                ('volumes/train/label', train_label),
                ('volumes/test/image', test_image),
                ('volumes/test/label', test_label)]

        for path, data in dest:
            if path in f:
                print('{} already there. Overwriting...'.format(path))
                del f[path]
            f.create_dataset(path, data=data)

        print('Created train samples {}'.format(f['volumes/train/image'].shape))
        print('Created test samples {}'.format(f['volumes/test/image'].shape))

        print("Done!")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='train-test split on give hdf file')
    parser.add_argument('filepath', help='path to hdf file')
    parser.add_argument('z', type=int, help='test size of z')
    parser.add_argument('x', type=int, help='test size of x')
    parser.add_argument('y', type=int, help='test size of y')
    args = parser.parse_args()

    train_test_split(filepath=args.filepath, z=args.z, x=args.x, y=args.y)


